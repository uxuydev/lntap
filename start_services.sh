#!/bin/bash

# 启动 lnd
lnd --trickledelay=5000 \
    --debuglevel=debug \
    --alias=mar-uxuy-lnd \
    --rpclisten=0.0.0.0:10009 \
    --listen=0.0.0.0:9735 \
    --bitcoin.node=neutrino \
    --bitcoin.active \
    --bitcoin.mainnet \
    --neutrino.addpeer=mainnet2-btcd.zaphq.io  \
    --neutrino.addpeer=mainnet1-btcd.zaphq.io   \
    --neutrino.addpeer=btcd-mainnet.lightning.computer        \
    --neutrino.addpeer=mainnet1-btcd.zaphq.io      \
    --neutrino.addpeer=mainnet2-btcd.zaphq.io      \
    --neutrino.addpeer=mainnet3-btcd.zaphq.io       \
    --neutrino.addpeer=mainnet4-btcd.zaphq.io      \
    --neutrino.addpeer=faucet.lightning.community \
    --feeurl=https://nodes.lightning.computer/fees/v1/btc-fee-estimates.json

# 启动 tapd
tapd --network=mainnet --debuglevel=debug --lnd.host=localhost:10009 \
 --lnd.macaroonpath=/root/.lnd/data/chain/bitcoin/mainnet/admin.macaroon \
 --lnd.tlspath=/root/.lnd/tls.cert \
 --tapddir=/root/.taprooot-assets --rpclisten=127.0.0.1:10029 --restlisten=127.0.0.1:8089
