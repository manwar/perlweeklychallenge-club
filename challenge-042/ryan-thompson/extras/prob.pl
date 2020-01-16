#!/usr/bin/env perl
#
# ch-2.pl - Validate balanced brackets
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util 'shuffle';

# To have any hope of being balanced, the string must be of even length,
# and must contain the same number of ( and ) brackets, so that's what we do.
sub gen_str { join '', shuffle map { ($_) x $_[0] } qw<( )> }

# This type of balance checking is trivial with a regex
sub balanced(_) { $_[0] =~ /^(\((?1)*\))*$/ }

use Algorithm::Combinatorics 'combinations';
use Number::Fraction;

# Check all strings of length 0..20
for my $n (0..10) {
    my $iter = combinations( [0 .. 2*$n-1], $n );

    my ($bal, $tot);
    while (my $i = $iter->next) {
        my @a   = ('(') x (2 * $n);
        @a[@$i] = (')') x $n;

        $tot++;
        $bal++ if balanced join '', @a;
    }
    printf "n = %2d: %5d / %-6d = %s\n",
        $n, $bal, $tot, Number::Fraction->new($bal, $tot);
}
