#!/usr/bin/perl

use strict;
use warnings;

use Math::Utils qw(floor);

my $search = $ARGV[0];
die "ERROR: Missing search key.\n" unless defined $search;

my @matrix = ( [  1,  2,  3,  5,  7 ],
               [  9, 11, 15, 19, 20 ],
               [ 23, 24, 25, 29, 31 ],
               [ 32, 33, 39, 40, 42 ],
               [ 45, 47, 48, 49, 50 ], );

my $found = 0;
foreach my $row (@matrix) {
    ($row->[0] > $search) and last;
    $found = binary_search($row, $search);
    $found and last;
}
print sprintf("%d %s.\n", $search, ($found)?("found"):("not found"));

=head1

Binary search algorithm as suggested by Wikipedia:

https://en.wikipedia.org/wiki/Binary_search_algorithm

    function binary_search(A, n, T) is
        L := 0
        R := n − 1

        while L ≤ R do
            m := floor((L + R) / 2)
            if A[m] < T then
                L := m + 1
            else if A[m] > T then
                R := m − 1
            else:
                return m

        return unsuccessful

=cut

sub binary_search {
    my ($row, $target) = @_;

    my $l = 0;
    my $r = @$row - 1;
    while ($l <= $r) {
        my $m = floor(( $l + $r ) / 2);
        if ($row->[$m] < $target) {
            $l = $m + 1;
        }
        elsif ($row->[$m] > $target) {
            $r = $m - 1;
        }
        else {
            return $m;
        }
    }

    return 0;
}
