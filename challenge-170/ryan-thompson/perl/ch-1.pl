#!/usr/bin/env perl
#
# ch-1.pl - Primordial numbers
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use Math::Prime::Util qw< prime_iterator >;

my $it = prime_iterator;

say my $pri = 1; # P(0) = 1 by definition
say $pri *= $it->() for 1..$ARGV[0] // 10;
