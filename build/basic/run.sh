#!/bin/sh

sed 's#%DB_SERVERNAME%#'"${DB_SERVERNAME}"'#' -i ./config.json
sed 's#%DB_DATABASE%#'"${DB_DATABASE}"'#' -i ./config.json
sed 's#%DB_PORT%#'"${DB_PORT}"'#' -i ./config.json
sed 's#%DB_USER%#'"${DB_USER}"'#' -i ./config.json
sed 's#%DB_PASS%#'"${DB_PASS}"'#' -i ./config.json

cd vendor
if [ ! -f ../init.lock ]; then
    npm run install-server
fi
npm run start