#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    # Store the string we will return
    my $output_string = '';

    # Loop through the input string, adding the necessary repetitions
    my $cnt = 0;
    foreach my $letter ( split //, $input_string ) {
        $output_string .= $letter x ++$cnt;
    }

    say $output_string;
}

main(@ARGV);
