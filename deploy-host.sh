#!/usr/bin/env bash

set -e
set -o pipefail

docker build -t ubuntu-samba .
docker run -d --restart unless-stopped \
	--network host \
	"$@" \
	ubuntu-samba
	