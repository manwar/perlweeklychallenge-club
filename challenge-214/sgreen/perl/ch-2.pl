#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub shrink_list(@array) {
    # Shrink the list if it has consecutive numbers
    my @new_array = [];
    foreach my $i (@array) {
        my ($number, $count) = @$i;
        if ($#new_array != -1 and $new_array[-1][0] == $number) {
            $new_array[-1] = [$number, $count + $new_array[-1][1]];
        }
        else {
            push @new_array, [$number, $count];
        }
    }

    return @new_array;
}

sub score_array(@array) {
    # Recursive function to get the highest score

    # Shrink the list if it has consecutive numbers
    @array = shrink_list(@array);

    if ($#array == 1) {
        # There is only one remaining number
        return $array[0][1] ** 2;
    }
    
    my $max_score = 0;

    while(my($i, $tup )= each @array) {
        # Create a copy of the array without the chosen element
        my @new_array = @array;
        splice(@new_array, $i, 1);

        # Calculate the maximum possible score recursively
        my $score = $tup->[1] ** 2 + score_array(@new_array);
        if ($score > $max_score) {
            $max_score = $score;
        }
    }

    # Return the maximum score
    return $max_score;
}

sub main(@array) {
    # Turn the list in a list of tuples of the number and the occurrences of it
    @array = map { [$_, 1] } @array;
    my $score = score_array(@array);
    say $score;
}

main(@ARGV);