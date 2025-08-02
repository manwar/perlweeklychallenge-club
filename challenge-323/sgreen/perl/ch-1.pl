#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@operations) {
    my $counter = 0;
    foreach my $operation (@operations) {
        if ($operation eq "x++" or $operation eq "++x") {
            $counter++;
        }
        elsif ($operation eq "x--" or $operation eq "--x") {
            $counter--;
        }
        else {
            die "Unknown operation: $operation}";
        }
    };

    say $counter;
}

main(@ARGV);