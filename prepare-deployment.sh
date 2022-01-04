#!/bin/bash

# build extension
cd ../giraffi-base-extension
./mvnw clean install
cd ../playground

# move artifacts to nginx
rm docker/nginx/files/*
mv ../giraffi-base-extension/runtime/target/*.jar docker/nginx/files/.

SHA_EXT=$(sha1sum docker/nginx/files/giraffi-base-extension-1.0.5.jar | awk '{ print $1 }')
MD5_EXT=$(md5sum docker/nginx/files/giraffi-base-extension-1.0.5.jar | awk '{ print $1 }')
SHA_CS=$(sha1sum docker/nginx/files/giraffi-base-extension-1.0.5-codestarts.jar | awk '{ print $1 }')
MD5_CS=$(md5sum docker/nginx/files/giraffi-base-extension-1.0.5-codestarts.jar | awk '{ print $1 }')

sed "s/MD5HASH_EXT/$MD5_EXT/g" docker/nginx/templates/default.conf_tmpl \
  | sed "s/MD5HASH_CS/$MD5_CS/g" \
  | sed "s/SHA1HASH_EXT/$SHA_EXT/g" \
  | sed "s/SHA1HASH_CS/$SHA_CS/g" > docker/nginx/config/default.conf

