#!/bin/sh

perl -E 'say scalar grep { $_ !~ /1/ } 1 .. @ARGV[0];' $@
