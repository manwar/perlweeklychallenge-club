#!/bin/sh

perl -E 'say scalar grep {/^["$ARGV[0]"]+$/} splice @ARGV,1' "$@"
