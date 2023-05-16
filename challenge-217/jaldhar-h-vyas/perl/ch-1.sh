#!/bin/sh

perl -E 'say 0+(sort { $a <=> $b } map { split /,/ } @ARGV)[2];' $@
