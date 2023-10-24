#!/bin/bash

SERVICE_NAME="lnd-service"
SERVICE_PATH="lnd --trickledelay=5000 \
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
"
PID_FILE="/root/$SERVICE_NAME.pid"
LOG_FILE="/root/$SERVICE_NAME.log"

start_service() {
    if [ -f "$PID_FILE" ]; then
        echo "$SERVICE_NAME is already running."
    else
        echo "Starting $SERVICE_NAME..."
        $SERVICE_PATH >> "$LOG_FILE" 2>&1 &
        echo $! > "$PID_FILE"
        echo "$SERVICE_NAME is now running with PID $!"
    fi
}

stop_service() {
    if [ -f "$PID_FILE" ]; then
        echo "Stopping $SERVICE_NAME..."
        PID=$(cat "$PID_FILE")
        kill "$PID"
        rm "$PID_FILE"
        echo "$SERVICE_NAME has been stopped."
    else
        echo "$SERVICE_NAME is not running."
    fi
}

restart_service() {
    stop_service
    start_service
}

case "$1" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    restart)
        restart_service
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0
