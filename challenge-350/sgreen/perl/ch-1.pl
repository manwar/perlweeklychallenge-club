#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub is_unique ($substr) {
    my %chars;
    foreach my $char (split //, $substr) {
        return 0 if exists $chars{$char};
        $chars{$char} = 1;
    }
    return 1;
}

sub main ($input_string) {
    my $count = 0;

    foreach my $i (0 .. length($input_string) - 3) {
        # Retrieve the three character substring from position i
        my $substr = substr($input_string, $i, 3);
        # If they are all different, increment the count
        $count++ if (is_unique($substr));
    }

    say $count;
}

main($ARGV[0]);
