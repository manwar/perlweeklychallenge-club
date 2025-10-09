#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub calculate_score ($input_string, $split_index) {
    # Split the string at each position and count the 0s on the left and 1s
    #  on the right
    my $left = substr($input_string, 0, $split_index);
    my $right = substr($input_string, $split_index);

    my $count_0 = ($left =~ tr/0//);
    my $count_1 = ($right =~ tr/1//);

    return $count_0 + $count_1;
}

sub main ($input_string) {
    # Check that the input contains only ones and zeros
    if ($input_string !~ /^[01]+$/) {
        die "Input must contain only '0' and '1' characters\n";
    }

    my $current_max = 0;

    # Calculate the score for each possible split
    foreach my $i (1 .. length($input_string)-1) {
        my $score = calculate_score($input_string, $i);

        # If the score is higher than the current max, update it
        if ($score > $current_max) {
            $current_max = $score;
        }
    }

    say $current_max;
}

main($ARGV[0]);