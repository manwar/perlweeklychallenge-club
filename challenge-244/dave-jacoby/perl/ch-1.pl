#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Compare;

my @examples = (

    [ 8, 1, 2, 2, 3 ],
    [ 6, 5, 4, 8 ],
    [ 2, 2, 2 ],
);
for my $e (@examples) {
    my @output = count_smaller( $e->@* );
    my $output = join ', ', @output;
    my $input  = join ', ', $e->@*;
    say <<~"END";
    Input:  \@int = ($input)
    Output: ($output)
    END
}

sub count_smaller (@input) {
    my @output;
    for my $v (@input) {
        # first pass, I copied the array to remove the current value
        # but once I realized that $v is never going to be less than 
        # itself, I decided to make it simpler.
        push @output, scalar grep { $_ < $v } @input;
    }
    return @output;
}
