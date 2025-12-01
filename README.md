# ihcoin

`ihcoin` is a simple fungible-style token implemented as a Clarity smart contract using the [Clarinet](https://github.com/hirosystems/clarinet) development environment.

The Clarinet project for the contract lives in `ihcoin-contract/`.

## Project structure

- `ihcoin-contract/`
  - `Clarinet.toml` – Clarinet project configuration
  - `contracts/ihcoin.clar` – main ihcoin smart contract
  - `settings/` – Clarinet network configuration (Devnet, Testnet, Mainnet)
  - `tests/ihcoin.test.ts` – placeholder for TypeScript unit tests

## ihcoin contract overview

The `ihcoin` contract implements a minimal fungible-style token with:

- `get-total-supply` – read-only, returns the current total supply
- `get-balance (owner principal)` – read-only, returns the balance for `owner`
- `transfer (amount uint) (sender principal) (recipient principal)` –
  moves `amount` from `sender` to `recipient` if `sender` has sufficient balance
- `mint (amount uint) (recipient principal)` –
  mints `amount` new tokens to `recipient` and increases total supply;
  only the contract owner may call this function

### Error codes

- `ERR-NOT-AUTHORIZED` (`err u100`) – caller is not allowed to perform the action
- `ERR-INSUFFICIENT-BALANCE` (`err u101`) – sender does not have enough balance

## Development workflow

### Prerequisites

- [Clarinet](https://docs.hiro.so/clarinet) installed and available on your `PATH`.

You can confirm this with:

```bash path=null start=null
clarinet --version
```

### Initialize the Clarinet project (already done)

Inside `ihcoin/`, the Clarinet project was created with:

```bash path=null start=null
clarinet new ihcoin-contract
cd ihcoin-contract
clarinet contract new ihcoin
```

You do not need to re-run these commands unless you are recreating the project from scratch.

### Running checks

From the Clarinet project directory:

```bash path=null start=null
cd ihcoin-contract
clarinet check
```

This will:

- Parse and analyze all contracts in `contracts/`
- Report any syntax or semantic issues

### Running tests

To run (and eventually add) TypeScript tests:

```bash path=null start=null
cd ihcoin-contract
npm install
npm test
```

Tests live in the `tests/` directory (for example, `tests/ihcoin.test.ts`).

## Next steps

- Implement concrete tests in `tests/ihcoin.test.ts`
- Extend the contract with additional controls (burning, pausing, allowances, etc.) as needed
- Integrate with a front-end or other on-chain contracts
