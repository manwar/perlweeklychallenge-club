#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Algorithm::Combinatorics qw(variations_with_repetition);

my @numbers = find_numbers([0, 1, 2, 5], 2, 21);
is (join(", ", @numbers), "10, 11, 12, 15, 20");

done_testing;

sub find_numbers {
    my ($n, $x, $y) = @_;

    my @numbers = ();
    foreach my $number (variations_with_repetition($n, $x)) {
        $number = join("", @$number) + 0;
        next unless ((length($number) == $x) && ($number < $y));
        push @numbers, $number;
    }

    return @numbers;
}
