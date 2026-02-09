#!/bin/sh

perl -E '$_=$ARGV[0];while(s/((.)\2)//g){}say' "$@"
