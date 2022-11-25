#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

	Task 1: Binary Flip
	You are given a positive integer, $n.
	Write a script to find the binary flip.

=cut

is(binaryFlip(5), 2, 'Example 1');
is(binaryFlip(4), 3, 'Example 2');
is(binaryFlip(6), 1, 'Example 3');

sub binaryFlip {
    my ($number) = @_;

    my %binaryDigitFlipMap = (
        '0' => '1',
        '1' => '0'
    );

    return oct("0b" . join("",  map { $binaryDigitFlipMap{$_} } split(//, sprintf("%b", $number))));
}

done_testing();
