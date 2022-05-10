#!/usr/bin/perl
use warnings;
use strict;

sub happy_numbers {
    my ($tally) = @_;
    my @happy_numbers;
    my $number = 1;

  CANDIDATE:
    while (@happy_numbers < $tally) {
        my $replace = $number;
        my %loop;
        my $sum;
        do {
            $sum = 0;
            $sum += $_ * $_ for split //, $replace;
            $replace = $sum;
            next CANDIDATE if $loop{$sum}++;

        } until 1 == $sum;

        push @happy_numbers, $number;

    } continue {
        ++$number;
    }

    return \@happy_numbers
}

use Test::More tests => 1;
is_deeply happy_numbers(8),
    [1, 7, 10, 13, 19, 23, 28, 31];
