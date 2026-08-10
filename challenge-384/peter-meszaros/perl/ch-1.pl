#!/usr/bin/env perl
#
=head1 Task 1: Base N

Submitted by: Mohammad Sajid Anwar

You are given a number and a base integer.  Write a script to convert the given
number in the given base integer.

=head2 Example 1

    Input: $num = 42, $base = 2
    Output: 101010

=head2 Example 2

    Input: $num = 15642094, $base = 16
    Output: EEADEE

=head2 Example 3

    Input: $num = 493, $base = 8
    Output: 755

=head2 Example 4

    Input: $num = 2228519, $base = 36
    Output: 1BRJB

    Base 36 uses numbers 0-9 and letters A-Z.

=head2 Example 5

    Input: $num = 123456789, $base = 64
    Output: 7MyqL

    Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {num => 42,        base =>  2, out => '101010', name => 'Example 1'},
    {num => 15642094,  base => 16, out => 'EEADEE', name => 'Example 2'},
    {num => 493,       base =>  8, out => '755',    name => 'Example 3'},
    {num => 2228519,   base => 36, out => '1BRJB',  name => 'Example 4'},
    {num => 123456789, base => 64, out => '7MyqL',  name => 'Example 5'},
);

sub base_n
{
    my $num  = shift;
    my $base = shift;

    my $out = '';
    my @digits = (0..9, 'A'..'Z', 'a'..'z', '+', '/');
    while ($num > 0) {
        $out = $digits[$num % $base] . $out;
        $num = int($num / $base);
    }
    return $out;
}

for my $case (@cases) {
    my $got = base_n($case->{num}, $case->{base});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
