#!/usr/bin/perl

=head1

Week 196:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-196

Task #2: Range List

    You are given a sorted unique integer array, @array.

    Write a script to find all possible Number Range i.e [x, y]
    represent range all integers from x and y (both inclusive).

=cut

use v5.36;
use Test2::V0;

is range_list(1,3,4,5,7),       [[3,5]],             'Example 1';
is range_list(1,2,3,6,7,9),     [[1,3],[6,7]],       'Example 2';
is range_list(0,1,2,4,5,6,8,9), [[0,2],[4,6],[8,9]], 'Example 3';

done_testing;

#
#
# METHOD

sub range_list(@list) {
    my $start = shift @list;
    my $curr  = $start;
    my @range = ();

    foreach my $next (@list) {
        next if ($next == $curr);
        if ($next == $curr + 1) {
            $curr = $next;
        }
        else {
            push @range, [$start, $curr]
                if ($curr > $start);
            $curr = $start = $next;
        }
    }

    push @range, [$start, $curr]
        if ($curr > $start);

    return \@range;
}
