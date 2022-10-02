Token addresses:

**WETH**: https://etherscan.io/address/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
**DAI**: https://etherscan.io/address/0x6b175474e89094c44da98b954eedeac495271d0f

Exchange addresses:
**UniswapV2:** https://etherscan.io/address/0xa478c2975ab1ea89e8196811f51a7b7ade33eb11
**Sushiswap:** https://etherscan.io/address/0xc3d03e4f041fd4cd388c549ee2a29a9e5075882f
**Shebaswap:** https://etherscan.io/address/0x8faf958e36c6970497386118030e6297fff8d275
**Sakeswap:** https://etherscan.io/address/0x2ad95483ac838e2884563ad278e933fba96bc242
**Croswap:** https://etherscan.io/address/0x60a26d69263ef43e9a68964ba141263f19d71d51

## Blueprint

```ml
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ solmate — https://github.com/Rari-Capital/solmate
scripts
├─ Deploy.s.sol — Simple Deployment Script
src
├─ Greeter — A Minimal Greeter Contract
test
└─ Greeter.t — Exhaustive Tests
```


## Development

**Setup**
```bash
forge install
```

**Building**
```bash
forge build
```

**Testing**
```bash
forge test
```

**Deployment & Verification**

Inside the [`utils/`](./utils/) directory are a few preconfigured scripts that can be used to deploy and verify contracts.

Scripts take inputs from the cli, using silent mode to hide any sensitive information.

_NOTE: These scripts are required to be _executable_ meaning they must be made executable by running `chmod +x ./utils/*`._

_NOTE: these scripts will prompt you for the contract name and deployed addresses (when verifying). Also, they use the `-i` flag on `forge` to ask for your private key for deployment. This uses silent mode which keeps your private key from being printed to the console (and visible in logs)._


### First time with Forge/Foundry?

See the official Foundry installation [instructions](https://github.com/foundry-rs/foundry/blob/master/README.md#installation).

Then, install the [foundry](https://github.com/foundry-rs/foundry) toolchain installer (`foundryup`) with:
```bash
curl -L https://foundry.paradigm.xyz | bash
```

Now that you've installed the `foundryup` binary,
anytime you need to get the latest `forge` or `cast` binaries,
you can run `foundryup`.

So, simply execute:
```bash
foundryup
```

🎉 Foundry is installed! 🎉


### Writing Tests with Foundry

With [Foundry](https://github.com/foundry-rs/foundry), all tests are written in Solidity! 🥳

Create a test file for your contract in the `test/` directory.

For example, [`src/Greeter.sol`](./src/Greeter.sol) has its test file defined in [`./test/Greeter.t.sol`](./test/Greeter.t.sol).

To learn more about writing tests in Solidity for Foundry, reference Rari Capital's [solmate](https://github.com/Rari-Capital/solmate/tree/main/src/test) repository created by [@transmissions11](https://twitter.com/transmissions11).


### Configure Foundry

Using [foundry.toml](./foundry.toml), Foundry is easily configurable.

For a full list of configuration options, see the Foundry [configuration documentation](https://github.com/foundry-rs/foundry/blob/master/config/README.md#all-options).


## License

[AGPL-3.0-only](https://github.com/abigger87/femplate/blob/master/LICENSE)


## Acknowledgements

- [femplate](https://github.com/abigger87/femplate)
- [foundry](https://github.com/foundry-rs/foundry)
- [solmate](https://github.com/Rari-Capital/solmate)
- [forge-std](https://github.com/brockelmore/forge-std)
- [forge-template](https://github.com/foundry-rs/forge-template)
- [foundry-toolchain](https://github.com/foundry-rs/foundry-toolchain)


## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._
