#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

while (<>) {
    #
    # Read in the input:
    #   - Extract a bunch of numbers from the input
    #   - Pair them up to form intervals
    #   - Pop the last one for $N
    #
    chomp;
    my @numbers = /[0-9]+/g;
    my @intervals;
    push @intervals => [splice @numbers => 0, 2] while @numbers;
    my $N = pop @intervals;

    #
    # Partition the intervals into three sets:
    #    - Intervals completely to the left of $N
    #    - Intervals intersecting $N
    #    - Intervals completely to the right of $N
    #
    # Each set my be empty. The first and last set will be unmodified.
    #
    my @pre  = grep {$$_ [1] <  $$N [0]} @intervals;
    my @mid  = grep {$$_ [0] <= $$N [1] &&
                     $$_ [1] >= $$N [0]} @intervals;
    my @post = grep {$$_ [0] >  $$N [1]} @intervals;

    #
    # Merge the middle set will be with $N, the result is a single interval:
    #    - If the middle set is not empty, and the start of the
    #      first interval in the set is to the left of the start
    #      of $N, the start point of the merged interval is the start
    #      point of the merged interval, else it's the start point of $N.
    #    - For the endpoint, we compare the end points of last interval
    #      in the middle set with the end point of $N.
    #  
    my $mid  = [@mid && $mid  [0] [0] < $$N [0] ? $mid  [0] [0] : $$N [0],
                @mid && $mid [-1] [1] > $$N [1] ? $mid [-1] [1] : $$N [1]];

    #
    # Print the result.
    #
    say join ", " => map {"(" . $$_ [0] . ", " . $$_ [1] . ")"}
                    @pre, $mid, @post;
}


__END__
