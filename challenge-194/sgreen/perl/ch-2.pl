#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main($s) {
    # Calculate the frequency of each letter
    my %letter_freq = ();
    foreach my $letter (split //, $s) {
        $letter_freq{$letter} += 1;
    }

    # Calculate the frequency of frequencies :)
    my %freq = ();
    foreach my $i (values(%letter_freq)) {
        $freq{$i} += 1;
    }

    my $solution = 0;
    # A solution is only possible if there are two different frequencies ...
    if (scalar keys(%freq) == 2) {
        my $min_freq = min(keys(%freq));
        my $max_freq = max(keys(%freq));

        # ... and the minimum frequency only occurs once,
        if ($min_freq == 1 and $freq{1} == 1) {
            $solution = 1;
        }

        # ... or the difference between them is 1, and the higher frequency
        #  only occurs once.
        elsif ($min_freq == $max_freq - 1 and $freq{$max_freq} == 1) {
            $solution = 1;
        }
    }
    elsif (scalar keys(%freq) == 1 && exists($freq{1})) {
        # ... or the only thing we have is single letters
        $solution = 1;
    }

    say $solution;
}

main($ARGV[0])