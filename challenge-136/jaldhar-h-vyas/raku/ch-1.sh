#!/bin/sh

raku -e  'say log2(@*ARGS[0] gcd @*ARGS[1]) % 1 == 0 ?? 1 !! 0' $@
