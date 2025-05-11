#!/bin/sh

raku -e 'say (@*ARGS[0].match(/(.)$0**2..*/,:g)).map({"\"$_\""}).join(", ")||q{""}' "$@"
