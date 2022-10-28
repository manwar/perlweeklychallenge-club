
=head1

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188/#TASK2

Task #2: Total Zero

    You are given two positive integers $x and $y.
    Write a script to find out the number of operations needed to make both ZERO.
    Each operation is made up either of
    '$x = $x - $y if $x >= $y'
    or
    '$y = $y - $x if $y >= $x (using the original value of $x)'.

=cut

use strict;
use warnings;
use feature 'say';

use Test::More;
use Data::Dumper;

$Data::Dumper::Indent = 0;

my @cases = (
    [ [ 5, 4 ], 5],
    [ [ 4, 6 ], 3 ],
    [ [ 2, 5 ], 4 ],
    [ [ 3, 1 ], 3 ],
    [ [ 7, 4 ], 5 ],
);
for my $case (@cases) {
    is_deeply( total_zero( @{ $case->[0] } ), $case->[1], Dumper( $case->[0] ) );
}

done_testing( scalar @cases );

sub total_zero {
    my ($x, $y) = @_;
    my $total = 0;
    while($x > 0 && $y > 0) {
        my ($new_x, $new_y, $count) = ($x, $y, 0);
        if ($x >= $y) {
            ($count, $new_x) = (int($x / $y), $x % $y);
            $total += $count;
        }
        if ($y >= $x) {
            ($count, $new_y) = (int($y / $x), $y % $x);
            $total += $count;
        }
        ($x, $y) = ($new_x, $new_y);
    }

    return $total;
}
