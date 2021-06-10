#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( solve_puzzle(1,2,3,4,5,6,7),
           [ [7, 2, 6, 1, 3, 5, 4],
             [7, 3, 2, 5, 1, 4, 6],
             [6, 4, 5, 1, 2, 7, 3],
             [6, 4, 1, 5, 2, 3, 7],
             [4, 5, 3, 1, 6, 2, 7],
             [5, 6, 2, 3, 1, 7, 4],
             [3, 7, 2, 1, 5, 4, 6],
             [4, 7, 1, 3, 2, 6, 5], ] );

done_testing;

=head1

    For my own sanity:

    Box 1 = a + b
    Box 2 = b + c + d
    Box 3 = d + e + f
    Box 4 = f + g

    For the purpose of the puzzle, the sum of all boxes should
    be a mulitple of 4.

    Box Sum = (a + b) + (b + c + d) + (d + e + f) + (f + g)
    => (a + b + c + d + e + f + g) + (b + d + f)
    => (Num Sum) + (b + d + f)

    Each Box Sum = ( (Num Sum) + (b + d + f) )  / 4

    Now find the different combinations of b, d and f that
    gives unique a, c, g and e as below:

    a = Each Box Sum - b
    c = a - d
    g = Each Box Sum - f
    e = g - d

=cut

sub solve_puzzle {
    my @n = @_;

    my $num_sum = 0;
    $num_sum += $_ for @n;

    my $solutions = [];
    foreach my $b (@n) {
        my @may_be_d = grep { $b != $_ } @n;
        foreach my $d (@may_be_d) {
            my @may_be_f = grep { $d != $_ } @may_be_d;
            foreach my $f (@may_be_f) {
                my $box_sum = $b + $d + $f + $num_sum;
                next unless ($box_sum % 4 == 0);
                my $each_box_sum = $box_sum / 4;

                my %rem = map { $_ => 1 } @may_be_f;
                delete $rem{$f};

                my $a = $each_box_sum - $b;
                next unless exists $rem{$a};
                delete $rem{$a};

                my $c = $a - $d;
                next unless exists $rem{$c};
                delete $rem{$c};

                my $g = $each_box_sum - $f;
                next unless exists $rem{$g};
                delete $rem{$g};

                my $e = $g - $d;
                next unless exists $rem{$e};

                push @$solutions, [$a, $b, $c, $d, $e, $f, $g];
            }
        }
    }

    return $solutions;
}
