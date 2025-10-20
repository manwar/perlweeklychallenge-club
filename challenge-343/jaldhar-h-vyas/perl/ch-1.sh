#!/bin/sh

perl -E 'say 0+(sort{$a<=>$b}map{abs(0-$_)}@ARGV)[0]' "$@"
