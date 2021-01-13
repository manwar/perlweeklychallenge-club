#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{uniq};
use Scalar::Util qw(looks_like_number);

## You are given an unsorted array of integers @N.
##
## Write a script to find the longest consecutive sequence.
## Print 0 if none sequence found.

# this allows user input for strings, making sure they're integers
# because never trust user input
if (@ARGV) {
    lsc( map { int $_ } grep { looks_like_number($_) } @ARGV );
}
else {
    my @arrays;

    # given examples
    push @arrays, [ 100, 4,  50, 3,  2 ];
    push @arrays, [ 20,  30, 10, 40, 50 ];
    push @arrays, [ 20,  19, 9,  11, 10 ];

    # my tests, and it said "unsorted integers", not "positive"
    push @arrays, [ 20 .. 23, 25 .. 28, 11 .. 18 ];
    push @arrays, [ 21, 20, 21, 0, -2, -1, -3, 1, 0 ];

    for my $array ( @arrays ) {
        lsc(@$array);
    }
}

sub lsc ( @array ) {
    say '';
    say join ', ', @array;

    # $zed is the array holding all sequences, including one-entry sequences
    # $n is the current sequence index
    my $zed = [];
    my $n   = 0;

    # they come unsorted but we want them sorted, 
    # and duplicate integers don't help us
    for my $i ( uniq sort { $a <=> $b } @array ) {
        
        # there are two cases where we don't want to move 
        # to the next index: there's nothing yet in the current
        # sequence and the current value is ready to fit into 
        # the current sequence.

        # thanks to Sawyer X for the more elegent way of
        # saying if (conditions) {} else { code }
        ( !$zed->[$n][-1] || $i == $zed->[$n][-1] + 1 ) or $n++;
        push $zed->[$n]->@*, $i;
    }

    # so, now $zed holds all the sequences, including one-entry
    # sequences, which do not count. 
    $zed->@* = 
        sort { scalar $b->@* <=> scalar $a->@* } # put longest first
        grep { scalar $_->@* > 1 } # remove too-small sequences
        $zed->@*;

    # if there's still a sequence, print the first entry
    # else, say 0
    if ( scalar $zed->@* ) {
        say join ', ', $zed->[0]->@*;
    }
    else {
        say 0;
    }
}

