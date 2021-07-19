#!/bin/sh
perl -E 'say $ARGV[0] ^ (1 << $ARGV[1] - 1);' $@