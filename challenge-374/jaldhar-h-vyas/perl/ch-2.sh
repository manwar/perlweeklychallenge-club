#!/bin/sh

perl -E 'say[sort{$b<=>$a}$ARGV[0]=~/((\d)\2*)/g]->[0]' "$@"
