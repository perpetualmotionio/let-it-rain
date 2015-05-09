#!/bin/sh
BASE=${1:-letitrain.ini.enc}
BASE=$(basename ${BASE} .enc)
openssl enc -d -aes256 -in ${BASE}.enc -out ${BASE}


