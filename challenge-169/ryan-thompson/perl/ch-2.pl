#!/usr/bin/env perl
#
# ch-2.pl - Achilles numbers
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use Math::Prime::Util qw< gcd factor_exp >;
use        List::Util qw< all any >;

say for achilles($ARGV[0] // 5000);

sub achilles {
    map  { $_->[0] }
    grep { all { $_ > 1 } @{$_->[1]} and gcd(@{$_->[1]}) == 1 }
    map  { [ $_ => [ map { $_->[1] } factor_exp($_) ] ] } 2..$_[0];
}
