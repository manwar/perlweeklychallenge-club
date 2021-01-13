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

    my $max_len = length($hist_max) + 1;
    my $total_len = 0;

    for my $i (reverse 1..$hist_max) {
        $out_str = sprintf "%${max_len}s", $i;
        $total_len += length($i);

        for my $bar (@$histogram) {
            $out_str .= $bar >= $i ? sprintf "%${max_len}s", '#' : sprintf "%${max_len}s", ' '
        }

        say $out_str;
        
    }

    $out_str = '_' x $max_len;
    $out_str .= '_' x ($max_len * scalar @$histogram);

    say $out_str;

    $out_str = ' ' x $max_len;
    $out_str .= sprintf "%${max_len}s", $_ for (@$histogram);

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

