#!/bin/sh

perl -MAlgorithm::Combinatorics=combinations -wl -e 'print scalar( grep { $ARGV[$_->[0]]==$ARGV[$_->[1]] } combinations [0 .. @ARGV-1], 2)' $@
