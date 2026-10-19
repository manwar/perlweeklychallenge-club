#!/usr/bin/env perl
#
=head1 Task 1: Complex Number

Submitted by: Mohammad Sajid Anwar

You are given two complex numbers as string.  Write a script to return the
multiplication of the given complex numbers.  Using the formula: (a + bi) x (c
+ di) = (ac - bd) + (ad + bc)i

=head2 Example 1

    Input: $num1 = "1+1i", $num2 = "1+1i"
    Output: "0+2i"

=head2 Example 2

    Input: $num1 = "1+(-1)i", $num2 = "1+(-1)i"
    Output: "0+(-2)i"

=head2 Example 3

    Input: $num1 = "0+3i", $num2 = "0+4i"
    Output: "-12+0i"

=head2 Example 4

    Input: $num1 = "3+4i", $num2 = "3+(-4)i"
    Output: "25+0i"

=head2 Example 5

    Input: $num1 = "50+(-20)i", $num2 = "-10+30i"
    Output: "100+1700i"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {num1 => "1+1i",      num2 => "1+1i",    out => "0+2i",      name => 'Example 1'},
    {num1 => "1+(-1)i",   num2 => "1+(-1)i", out => "0+(-2)i",   name => 'Example 2'},
    {num1 => "0+3i",      num2 => "0+4i",    out => "-12+0i",    name => 'Example 3'},
    {num1 => "3+4i",      num2 => "3+(-4)i", out => "25+0i",     name => 'Example 4'},
    {num1 => "50+(-20)i", num2 => "-10+30i", out => "100+1700i", name => 'Example 5'},
);

sub complex_number
{
    my $num1 = shift;
    my $num2 = shift;

    my $cplx = qr/(-?\d+)\+\(?(-?\d+)\)?i/;
    my ($a, $b) = $num1 =~ /$cplx/;
    my ($c, $d) = $num2 =~ /$cplx/;
    my $real = $a * $c - $b * $d;
    my $imag = $a * $d + $b * $c;
    $imag = "($imag)" if $imag < 0;
    return "$real+$imag" . "i";
}

for my $case (@cases) {
    my $got = complex_number($case->{num1}, $case->{num2});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
