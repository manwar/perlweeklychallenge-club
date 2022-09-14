#!/bin/sh

perl -MList::Util='max' -E 'for (0 .. $#ARGV) {if ($ARGV[$_]==max(@ARGV)) {say;}}' 5 2 9 1 7 6

#2

#perl -MList::Util='max' -E 'for (0 .. $#ARGV) {if ($ARGV[$_]==max(@ARGV)) {say;}}' 4 2 3 1 5 0

#4
