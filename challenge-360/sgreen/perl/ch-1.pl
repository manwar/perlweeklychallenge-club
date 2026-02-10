#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use POSIX qw(ceil floor);

sub main ($input_string, $width) {
    my $string_len = length($input_string);

    if ($string_len >= $width) {
        # No change required
        say $input_string;
        return;
    }

    # How many asterisks are needed on each side
    my $asterisks = ($width-$string_len) / 2;
    my $output_string = "*" x floor($asterisks) . $input_string . "*" x ceil($asterisks);

    if (length($output_string) < $width) {
        # Add last star if required
        $output_string .= "*";
    }

    say $output_string;
}

main(@ARGV);