#!/bin/sh

perl -E 'say q{(},(join q{, },(map{$_?$_:(0,0)}@ARGV)[0..$#ARGV]),q{)}' "$@"
