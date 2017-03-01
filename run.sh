#!/bin/sh
if [ ! -f /usr/app/horizon-key.pem ] && [ $HZ_SECURE == 'yes' ]; then
	echo "Generating Horizon app certificate"
	hz create-cert
fi
chown -R daemon:daemon /usr/app
exec su-exec daemon:daemon hz serve --bind all -p "${HZ_PORT:-8181}" --connect "${RETHINKDB_URI:-rethinkdb://rethinkdb:28015}" /usr/app
