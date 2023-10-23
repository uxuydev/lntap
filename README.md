# LnTap
LnTap is Lightning & Taproot Asset All-in-One Docker, and here is the cli guide for initial version,
We are going to provide webui to common users.

```
docker build -t lntap .
```

```
docker run -it lntap /bin/bash
```

## lncli create
you can create a new wallet or import your seeds to restore your wallet.

if you do not have address
```
lncli newaddress p2tr
```

if you already have p2tr address 
```
lncli wallet addresses list
```

## Ensure the balance and going to tap daemon

```
docker exec -it 41535046832b /bin/bash
```

## Mint Token
```
tapcli --network=mainnet --tapddir=/root/.taprooot-assets assets mint --type normal --name beefbux --supply 100 --meta_bytes 66616e746173746963206d6f6e6579 --enable_emission
```

## Finalize Mint
```tapcli --network=mainnet --tapddir=~/.taprooot-assets assets mint finalize```

## Check the Assets List
```tapcli --network=mainnet --tapddir=~/.taprooot-assets tapcli assets list```

## Sync Data to Universe
```tapcli --network=mainnet --tapddir=~/.taprooot-assets universe federation add --universe_host universe.lightning.finance
tapcli --network=mainnet --tapddir=~/.taprooot-assets u sync --unverse_host universe.lightning.finance
```
## Receive Assets
### Generate the receive address
```tapcli --network=mainnet --tapddir=~/.taprooot-assets addrs new --asset_id ed43c09dd425ec25051c0e467ca1852d624974c503625f38fbb679bbdf89d790 --amt 7
```
### Send 
```tapcli --network=mainnet --tapddir=~/.taprooot-assets assets send --addr tapbc1qqqsqqspqqzzpm2rczwagf0vy5z3crjx0jsc2ttzf96v2qmztuu0hdneh00cn4usq5ss89mey0962l2gjldu8z25gfexxg0dfax5qx9efgntn3spswdhelyeqcss9wam6p2ngmv7rc9j50gt7e2rdsjfeh5wj0rjzx9xhlgglntny6trpqss8vg4vmyczxctwjx6hydyh5sj9jcyuankp444az39vr4kjw8tewwepgqswrpww4hxjan9wfek2unsvvaz7tm4de5hvetjwdjjumrfva58gmnfdenjuenfdeskucm98gcnqvpj8yevw3gx
```