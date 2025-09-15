#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-15
use utf8;     # Week 339 - task 1 - Max diff
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Algorithm::Combinatorics 'variations';

max_diff(5, 9, 3, 4, 6);
max_diff(1, -2, 3, -4);
max_diff(-3, -1, -2, -4);
max_diff(10, 2, 0, 5, 1);
max_diff(7, 8, 9, 10, 10);
max_diff(0, 0, 0, 0, 0);
max_diff(5, 5, 5, 5, 5);
max_diff(-5, -5, -5, -5, -5);

# 50 random numbers in [-250 .. +250]
my @ints;
push @ints, int(rand(501)) - 250 for 1 .. 50;
max_diff(@ints);

sub max_diff {
    
    my ($best, $iter, $c, $diff, $pairs);
    
    # initialise
    $best = -1;
    $iter = variations(\@_, 4);
    
    # iterate over all variations
    while ($c = $iter->next) {
        
        # is this one the best so far?
        $diff = abs($c->[0] * $c->[1] - $c->[2] * $c->[3]);
        if ($diff > $best) {
            $best = $diff;
            $pairs = qq[($c->[0], $c->[1]), ($c->[2], $c->[3])];
        }
    }

    say qq[\nInput:  (] . join(', ', @_) . ')';
    say qq[Output: $best\n        $pairs];
}