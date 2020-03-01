#!/usr/bin/env bash

if [ "${FRPC_X_MODE}" == 'stcp' ] ; then
    exec /frp/frpc -c /frp/frpc-stcp.ini
elif [ "${FRPC_X_MODE}" == 'visitor' ] ; then
    exec /frp/frpc -c /frp/frpc-visitor.ini
else
    exec /frp/frpc -c /frp/frpc.ini
fi
