#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Algorithm::Combinatorics qw(variations_with_repetition);

my @n = (0, 1, 2, 5);
my $x = 2;
my $y = 21;

my @numbers = find_numbers(\@n, $x, $y);
is (join(", ", @numbers), "10, 11, 12, 15, 20");

done_testing;

sub find_numbers {
    my ($n, $x, $y) = @_;

    my @numbers = ();
    foreach my $number (variations_with_repetition(\@n, $x)) {
        $number = join("", @$number) + 0;
        next unless ((length($number) == $x) && ($number < $y));
        push @numbers, $number;
    }

    return @numbers;
}
