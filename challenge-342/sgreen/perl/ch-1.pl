#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($input_string) {
    # Separate letters and digits
    my @digits = sort { $a <=> $b } grep { /[0-9]/ } split //, $input_string;
    my @letters = sort { lc($a) cmp lc($b) } grep { /[A-Za-z]/ } split //, $input_string;

    # If the difference in length is more than 1, there is no solution
    if (abs(scalar(@digits) - scalar(@letters)) > 1) {
        say '""';
        return;
    }

    # If the lengths are unequal, add a blank to the shorter list
    if (scalar(@digits) < scalar(@letters)) {
        unshift @digits, '';
    } elsif (scalar(@letters) < scalar(@digits)) {
        push @letters, '';
    }

    # Interleave the two lists, digits first
    my $solution = "";
    foreach my $i (0 .. $#digits) {
        $solution .= $digits[$i] . $letters[$i];
    }

    say '"', $solution, '"';
}

main($ARGV[0]);