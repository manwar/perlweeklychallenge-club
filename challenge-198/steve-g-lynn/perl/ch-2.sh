#!/bin/sh

perl -MMath::Prime::Util=prime_count -wl -e 'print prime_count($ARGV[0]-1)' $@
