#!/usr/bin/env perl
use v5.34;

use experimental qw(signatures);

=pod
You are given a list of integers, @list.

Write a script to find the total pairs in the sorted list where 2 consecutive elements has the max gap. If the list contains less then 2 elements then return 0.

=cut

sub find_total_pairs (@ints)
{
    return find_total_pairs_sorted( sort(@ints) );
}

sub find_total_pairs_sorted ( $first, @ints )
{
    return 0 unless @ints;
    my $max_delta = 0;
    my $max_count = 0;
    my $previous  = $first;
    for my $i (@ints)
    {
        my $delta = $i - $previous;
        $previous = $i;

        if ( $delta == $max_delta )
        {
            $max_count++;
        }
        elsif ( $delta > $max_delta )
        {
            $max_count = 1;
            $max_delta = $delta;
        }
    }
    return $max_count;
}

sub find_total_pairs_sorted_orig ( $first, @ints )
{
    return 0 unless @ints;
    my %gap_pairs;
    my $max_delta = 0;
    my $previous  = $first;
    for my $i (@ints)
    {
        my $delta = $i - $previous;
        $gap_pairs{$delta}++;
        if ( $delta > $max_delta )
        {
            $max_delta = $delta;
        }
        $previous = $i;
    }
    say %gap_pairs;
    return $gap_pairs{$max_delta};
}

sub main
{
    say "pairs: " . find_total_pairs( 2, 5, 8, 1 );
    say "pairs: " . find_total_pairs(3);
}

main();
