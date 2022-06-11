#!/usr/bin/perl
use warnings;
use strict;

sub rob_the_house {
    my (@valuables) = @_;
    my @sums;
    for my $i (reverse 0 .. $#valuables) {
        $sums[$i] = $valuables[$i];
        if ($i + 2 <= $#valuables) {
            my $add = $sums[$i + 2];
            $add = $sums[$i + 3] if $i + 3 <= $#valuables
                                 && $sums[$i + 3] > $sums[$i + 2];
            $sums[$i] += $add;
        }
    }
    return $sums[0]
}

use Test::More tests => 3;

is rob_the_house(2, 4, 5), 7, 'Example 1';
is rob_the_house(4, 2, 3, 6, 5, 3), 13, 'Example 2';
is rob_the_house((1) x 1000), 500, 'Long';

=head1 Explanation

 D C B X A

Let's proceed in reverse. Before robbing A, we couldn't have robbed X, but we
could have robbed B, C, or D. But going directly from D to A makes no sense,
as we could have robbed B on the way. Therefore, we just need to compare C and
B.

=cut
