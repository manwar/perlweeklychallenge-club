#!/usr/bin/env perl
#
=head1 Task 1: Reverse Base

Submitted by: Mohammad Sajid Anwar

You are given a string representing a number, and an integer specifying the
base of that representation. Write a function to convert this string to an
integer. (For bases greater than 10, use characters A-Z, a-z, + and / in that
order.)

=head2 Example 1

    Input: $num = "101010", $base = 2
    Output: 42

=head2 Example 2

    Input: $num = "EEADEE", $base = 16
    Output: 15642094

=head2 Example 3

    Input: $num = "755", $base = 8
    Output: 493

=head2 Example 4

    Input: $num = "1BRJB", $base = 36
    Output: 2228519

=head2 Example 5

    Input: $num = "7MyqL", $base = 64
    Output: 123456789

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {num => "101010", base =>  2, out =>        42, name => 'Example 1'},
    {num => "EEADEE", base => 16, out =>  15642094, name => 'Example 2'},
    {num => "755",    base =>  8, out =>       493, name => 'Example 3'},
    {num => "1BRJB",  base => 36, out =>   2228519, name => 'Example 4'},
    {num => "7MyqL",  base => 64, out => 123456789, name => 'Example 5'},
);

sub reverse_base
{
    my $num  = shift;
    my $base = shift;

    my $result = 0;
    my @digits = split //, $num;
    my $len = @digits;
    for my $i (0 .. $len - 1) {
        my $digit = $digits[$i];
        my $value;
        if ($digit =~ /[0-9]/) {
            $value = ord($digit) - ord('0');
        } elsif ($digit =~ /[A-Z]/) {
            $value = ord($digit) - ord('A') + 10;
        } elsif ($digit =~ /[a-z]/) {
            $value = ord($digit) - ord('a') + 36;
        } elsif ($digit eq '+') {
            $value = 62;
        } elsif ($digit eq '/') {
            $value = 63;
        } else {
            return undef;
        }
        if ($value >= $base) {
            return undef;
        }
        $result = $result * $base + $value;
    }
    return $result;
}

for my $case (@cases) {
    my $got = reverse_base($case->{num}, $case->{base});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
