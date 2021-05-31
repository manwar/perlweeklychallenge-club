#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my @words = @_;

    # Get the first and last letter of each word, sorted alphabetically
    my $first_letters = join '', sort map { substr( $_, 0, 1 ) } @words;
    my $last_letters  = join '', sort map { substr( $_, -1 ) } @words;

    # If they are the same, we have a circle
    say( $first_letters eq $last_letters ) ? 1 : 0;
}

main(@ARGV);
