#!/usr/bin/perl

use v5.16;
use warnings;
use Math::Prime::Util 'numtoperm';

die <<EOS if @ARGV != 2;
usage: $0 N K

N
    permute numbers from 1 to N

K
    print k-th permutation of the numbers (one-based)

EOS

say "@{[map $_ + 1, numtoperm $ARGV[0], $ARGV[1] - 1]}";
