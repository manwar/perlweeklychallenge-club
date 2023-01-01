#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(any mesh);

sub main (@list) {
    # Sort the list, find the mid point
    @list = sort { $b <=> $a } @list;
    my $mid_point = int( scalar(@list) / 2 );

    # Split the list into big_n and small_n
    my @big_list   = @list[ 0 .. $mid_point - 1 ];
    my @small_list = @list[ $mid_point .. $#list ];

    # Merge the lists together
    my @solution = grep { defined($_) } mesh( \@small_list, \@big_list );

    # There is no solution if two subsequent numbers are equal
    if ( any { $solution[ $_ - 1 ] == $solution[$_] } ( 1 .. $#solution ) ) {
        say 'No solution possible!';
    }
    else {
        say join ', ', @solution;
    }
}

main(@ARGV);