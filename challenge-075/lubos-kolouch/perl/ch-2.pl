#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw/max/;
use feature qw/say/;
# Perl Weekly challenge 075 Task 2 - Largest histogram 


sub printHistogram {
    my $histogram = shift;

    my $hist_max = max(@$histogram);
    my $out_str;

    for my $i (reverse 1..$hist_max) {
        $out_str = $i;

        for my $bar (@$histogram) {
            $out_str .= $bar >= $i? '#' : ' '
        }

        say $out_str;
        
    }

    $out_str = '_';
    $out_str .= '_' x scalar @$histogram;

    say $out_str;

    $out_str = ' ';
    $out_str .= $_ for (@$histogram);

    say $out_str;
}

sub largestRectangle {
    my $histogram = shift;
    
    my @stack;
    my $max_area = 0;
    my $index = 0;

    while ($index < scalar @$histogram) {
        if ( (not @stack) or ($histogram->[$stack[-1]] <= $histogram->[$index]) ) {
            push @stack, $index;
            $index ++;
        } else {
            my $top_of_stack = pop @stack;
            my $area = @stack ? $histogram->[$top_of_stack] * ($index - $stack[-1] - 1) : $index;

            $max_area = max($max_area, $area);
        }
    }

    while (@stack) {
            my $top_of_stack = pop @stack;
            my $area = @stack ? $histogram->[$top_of_stack] * ($index - $stack[-1] - 1) : $index;

            $max_area = max($max_area, $area);
    }
    printHistogram($histogram);

    return $max_area;
}

use Test::More;

is(largestRectangle([2, 1, 4, 5, 3, 7]), 12);
is(largestRectangle([3, 2, 3, 5, 7, 5]), 15);

