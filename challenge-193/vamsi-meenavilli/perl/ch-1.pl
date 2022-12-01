#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

	https://theweeklychallenge.org/blog/perl-weekly-challenge-193

    Task 1: Binary String
    Submitted by: Mohammad S Anwar
    You are given an integer, $n > 0.

    Write a script to find all possible binary numbers of size $n.

=cut

is(binaryString(2), ['00', '01', '10', '11'], 'Example 1');
is(binaryString(3), ['000', '001', '010', '011', '100', '101', '110', '111'], 'Example 2');

sub binaryString {
    my ($binary_number_size) = @_;

    my @binary_strings = ();
    for (my $i = 0; $i < 2**$binary_number_size; $i++) {
        push(@binary_strings, sprintf("%0${binary_number_size}b", $i))
    }

    return(\@binary_strings);
}

done_testing();