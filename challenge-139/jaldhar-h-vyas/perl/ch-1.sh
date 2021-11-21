#!/bin/sh

perl -Mexperimental=smartmatch -E  'say [@ARGV] ~~ [sort { $a <=> $b } @ARGV] ? 1 : 0;' $@