#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

MaxOddBinary - Rearrange bits to get maximum odd binary number

=head1 SYNOPSIS

    perl ch-1.pl <binary_string>

=head1 DESCRIPTION

Given a binary string containing at least one '1', rearrange the bits to form the maximum odd binary number. Return the resulting binary string (may have leading zeros).

=cut

sub max_odd_binary {
    my ($bin) = @_;
    die "Input must contain at least one '1'\n" unless $bin =~ /1/;
    my $ones = () = $bin =~ /1/g;
    my $zeros = length($bin) - $ones;
    # Result: ($ones-1) '1's, then zeros, then one '1' at the end
    return ('1' x ($ones - 1)) . ('0' x $zeros) . '1';
}

# Test cases
use Test::More tests => 5;

is(max_odd_binary('110'), '101', 'Example 1: "110" -> "101"');
is(max_odd_binary('010'), '001', 'Example 2: "010" -> "001"');
is(max_odd_binary('1'), '1', 'Single "1"');
is(max_odd_binary('1010'), '1001', 'Four bits with two ones -> maximum odd is 1001');
is(max_odd_binary('0010110'), '1100001', 'Seven bits with three ones -> maximum odd is 1100001');

=head1 EXAMPLES

    perl ch-1.pl 110
    # Output: 101

    perl ch-1.pl 010
    # Output: 001

=cut
