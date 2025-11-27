#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=head1 DESCRIPTION

Total XOR (Weekly Challenge 324)

Compute the sum of XOR values over every subset of the input list.

=cut

sub total_xor (@ints) {
    my $sum = 0;
    my $n   = scalar @ints;
    my $subsets = 1 << $n;
    for my $mask (1 .. $subsets - 1) {    # non-empty subsets
        my $xor = 0;
        for my $i (0 .. $n - 1) {
            $xor ^= $ints[$i] if $mask & (1 << $i);
        }
        $sum += $xor;
    }
    return $sum;
}

if (!caller) {
    require Test::More;
    Test::More::is( total_xor(1, 3), 6, 'Example 1' );
    Test::More::is( total_xor(5, 1, 6), 28, 'Example 2' );
    Test::More::is( total_xor(3, 4, 5, 6, 7, 8), 480, 'Example 3' );
    Test::More::done_testing();
}
