#!/usr/bin/perl -s

use strict;
use warnings;

die <<EOS unless @ARGV == 1;
usage: $0 N

N
    print decimal and octal representations of number up to N

EOS

printf "Decimal %u = Octal %o\n", ($_) x 2 for 0 .. shift;
