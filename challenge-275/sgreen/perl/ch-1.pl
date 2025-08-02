#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'all';

sub main ($str, @keys) {
    # Convert values to lowercase
    my @words = split ' ', lc $str;
    @keys = map { lc } @keys;

    # Initialize the counter
    my $count = 0;

    # Loop through the strings
    foreach my $word (@words) {
        if (all { index($word, $_) ==-1 } @keys) {
            $count++;
        }
    }

    say $count;
}

main($ARGV[0], @ARGV[1..$#ARGV]);