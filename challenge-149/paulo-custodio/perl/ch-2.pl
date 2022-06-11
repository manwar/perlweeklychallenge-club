#!/usr/bin/env perl

# Challenge 149
#
# TASK #2 › Largest Square
# Submitted by: Roger Bell_West
# Given a number base, derive the largest perfect square with no repeated
# digits and return it as a string. (For base>10, use ‘A’..‘Z’.)
#
# Example:
#     f(2)="1"
#     f(4)="3201"
#     f(10)="9814072356"
#     f(12)="B8750A649321"

use Modern::Perl;
use Math::Combinatorics;
use Math::BaseCnv;

my $base = shift || 2;
say largest_perfect_square($base);


sub largest_perfect_square {
    my($base) = @_;
    my @digits = (0..9, 'A'..'Z')[0 .. $base-1];

    my $max_num = 0;
    my $max_str = "0";
    my $combinat = Math::Combinatorics->new(count => $base, data => \@digits);
    while (my @permu = $combinat->next_permutation) {
        my $str = join("", @permu);
        $str =~ s/^0+(\d)/$1/;
        my $num = cnv($str, $base, 10);
        if (int(sqrt($num)) == sqrt($num)) {    # is perfect square
            if ($num > $max_num) {
                ($max_num, $max_str) = ($num, $str);
            }
        }
    }
    return $max_str;
}
