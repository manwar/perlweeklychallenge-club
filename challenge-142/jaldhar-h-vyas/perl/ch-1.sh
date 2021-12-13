#!/bin/sh

perl -E 'say scalar grep { $ARGV[0] % $_ == 0 && $_ =~ /$ARGV[1]$/ } 1 .. $ARGV[0] - 1;' $@
