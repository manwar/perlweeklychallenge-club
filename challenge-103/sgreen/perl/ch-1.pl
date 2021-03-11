#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub main {
    my $year = shift;

    # Sanity check
    die "You must enter a year\n" if not defined $year;
    die "The year does not look like a positive integer\n" unless $year =~ /^\d+$/;

    my @zodiacs  = (qw(Monkey Rooster Dog Pig Rat Ox Tiger Rabbit Dragon Snake Horse Goat));
    my @elements = (qw(Metal Water Wood Fire Earth));

    # State the zodiac sign
    say $elements[ int( $year / 2 ) % 5 ], ' ', $zodiacs[ $year % 12 ];
}

main(@ARGV);
