#!/bin/sh
if [ ! -f /horizon/app/horizon-key.pem ]; then
	echo "Generating Horizon app certificate"
	hz create-cert
fi
chown -R daemon:daemon /horizon
exec su-exec daemon:daemon hz serve --bind all -p "${HZ_PORT:-8181}" --connect "${RETHINKDB_URI:-rethinkdb://rethinkdb:28015}" /horizon/app
