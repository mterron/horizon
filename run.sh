#!/bin/sh
# Fix nodejs PaX extended attributes
attr -s pax.flags -V em $(which node)

if [ ! -f /usr/app/horizon-key.pem ] && [ ${HZ_SECURE:-yes} == 'yes' ]; then
	echo "Generating Horizon app certificate"
	sed -i "11icountryName_default\t\t= ${CERT_COUNTRY:-NZ}" /etc/ssl/openssl.cnf
	hz create-cert
fi

chown -R daemon:daemon /usr/app
exec su-exec daemon:daemon hz serve --bind all -p "${HZ_PORT:-8181}" --connect "${RETHINKDB_URI:-rethinkdb://rethinkdb:28015}" /usr/app
