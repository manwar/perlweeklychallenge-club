#!/usr/bin/perl

use strict;
use v5.24;

my $count = shift;
say 'You chose a count of 0, please provide a different count.' and exit if $count == 0;
say 'There are not enough elements, please provide more elements to replace.' and exit if @ARGV < 3;
for (my $i = 1; $i < $#ARGV - 1; $i++) {
    if (!($ARGV[$i - 1] + $ARGV[$i] + $ARGV[$i + 1])) {$ARGV[$i] = 1 and $count--}
}
say ($count > 0 ? '0' : '1');
