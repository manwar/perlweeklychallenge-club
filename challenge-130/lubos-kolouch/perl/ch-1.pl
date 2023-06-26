#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(reduce);

my @N = (2, 5, 4, 4, 5, 5, 2);
my $odd = reduce { $a ^ $b } @N;
print "$odd\n";

