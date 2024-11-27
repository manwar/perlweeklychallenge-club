#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use FindBin ();

my $eval = "";
open my $source, '<',
    "$FindBin::Bin/../../../challenge-174/e-choroba/perl/ch-2.pl"
    or die $!;
while (<$source>) {
    last if /^use Test::More/;
    $eval .= $_
}
eval $eval;

sub next_permutation(@ints) {
    my $rank = 1 + permutation2rank(\@ints);
    $rank %= factorial(scalar @ints);  # Last permutation cycles back to 1st.
    return rank2permutation(\@ints, $rank)
}

use Test2::V0;
plan(3 + 1);

is next_permutation(1, 2, 3), [1, 3, 2], 'Example 1';
is next_permutation(2, 1, 3), [2, 3, 1], 'Example 2';
is next_permutation(3, 1, 2), [3, 2, 1], 'Example 3';
is next_permutation(3, 2, 1), [1, 2, 3], 'Last';
