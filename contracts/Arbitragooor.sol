// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./MultiCall.sol";
import "./Auth.sol";
import "./interfaces";

interface IERC20 {
    function balanceOf(address owner) external view returns (uint);
    function transfer(address to, uint value) external returns (bool);
}

interface IWETH is IERC20 {
    function deposit() external payable;
    function withdraw(uint256) external;
}

contract Arbitragooor is Multicall {
    address public immutable hub;
    address public immutable weth;
    address immutable UNIFACTORY;
    address immutable SUSHIROUTER;

    constructor(
        address _hub,
        address _weth,
        address _owner,
        address _executor
    ) Auth(_owner, _executor) {
        hub = _hub;
        weth = _weth;
    }

    receive() external payable {}

    modifier ensureProfitAndPayFee(
        address tokenIn,
        uint256 amtNetMin,
        uint256 txFeeEth
    ) {
        uint256 balanceBefore = IERC20(tokenIn).balanceOf(address(this));
        _;
        uint256 balanceAfter = IERC20(tokenIn).balanceOf(address(this));
        require(balanceAfter >= balanceBefore + amtNetMin, "not profitable");

        if (txFeeEth > 0) {
            uint256 ethBalance = address(this).balance;
            if (ethBalance < txFeeEth) IWETH(weth).withdraw(txFeeEth - ethBalance);
            block.coinbase.transfer(txFeeEth);
        }
    }

    function work(
        address tokenIn,
        uint256 amtNetMin,
        uint256 txFeeEth,
        bytes calldata data
    ) external payable onlyOwnerOrExecutor ensureProfitAndPayFee(tokenIn, amtNetMin, txFeeEth) {
        (bool success, bytes memory ret) = hub.call(data);
        _require(success, ret);
    }

    function uniswapV2Call(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external {
        // There are probably cheaper ways but in general not worth wasting security
        address token0 = SushiPair(msg.sender).token0(); // fetch the address of token0
        address token1 = SushiPair(msg.sender).token1(); // fetch the address of token1

	// You can calc this without the external call btw, it just involves hashing the factory init code and can be confusing to put in an example
        require(msg.sender == SushiFactory(UNIFACTORY).getPair(token0, token1)); // ensure that msg.sender is a V2 pair
        require(sender == address(this));

        (uint256 repay) = abi.decode(data, (uint256));

        // Maybe make this a router call?
        if (amount0 == 0) {
            // Trade A into B
            ERC20(token1).approve(SUSHIROUTER, MAX_UINT);

            address[] memory route = new address[](2);

            route[0] = token1;
            route[1] = token0;

            uint256[] memory tokensOut =
                SushiRouter(SUSHIROUTER).swapExactTokensForTokens(amount1, 0, route, address(this), MAX_UINT);

            require(tokensOut[1] - repay > 0); // ensure profit is there

            ERC20(token0).transfer(msg.sender, repay);
        } else {
            // Trade B into A
            ERC20(token0).approve(SUSHIROUTER, MAX_UINT);

            address[] memory route = new address[](2);
            route[0] = token0;
            route[1] = token1;

            uint256[] memory tokensOut =
                SushiRouter(SUSHIROUTER).swapExactTokensForTokens(amount0, 0, route, address(this), MAX_UINT);

            require(tokensOut[1] - repay > 0); // ensure profit is there

            ERC20(token1).transfer(msg.sender, repay);
        }
    }
}