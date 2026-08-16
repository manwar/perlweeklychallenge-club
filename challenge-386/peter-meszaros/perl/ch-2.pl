#!/usr/bin/env perl
#
=head1 Task 2: Rational Numbers

Submitted by: Mohammad Sajid Anwar

You are given two strings representing non-negative rational numbers. Write a
script to return true if the two given rational numbers are same otherwise
false.

=head2 Example 1

    Input: $rat1 = "0.(12)"
           $rat2 = "0.(121)"
    Output: false

    Expansion of "0.(12)"  = 0.12 12 12 12
    Expansion of "0.(121)" = 0.121 121 121

=head2 Example 2

    Input: $rat1 = "0.1(23)"
           $rat2 = "0.12(32)"
    Output: true

=head2 Example 3

    Input: $rat1 = "0.1(234)"
           $rat2 = "0.12(342)"
    Output: true

    Expansion of "0.1(234)"  = 0.1 234 234 234
    Expansion of "0.12(342)" = 0.12 342 342 342

=head2 Example 4

    Input: $rat1 = "12.99(99)"
           $rat2 = "13."
    Output: true

=head2 Example 5

    Input: $rat1 = "0.(123)"
           $rat2 = "0.1(231)"
    Output: true

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {rat1 => "0.(12)",    rat2 => "0.(121)",   out => false, name => 'Example 1'},
    {rat1 => "0.1(23)",   rat2 => "0.12(32)",  out => true,  name => 'Example 2'},
    {rat1 => "0.1(234)",  rat2 => "0.12(342)", out => true,  name => 'Example 3'},
    {rat1 => "12.99(99)", rat2 => "13.",       out => true,  name => 'Example 4'},
    {rat1 => "0.(123)",   rat2 => "0.1(231)",  out => true,  name => 'Example 5'},
);

sub _to_fraction {
    my $s = shift;

    my ($whole, $decimal) = split /\./, $s, 2;
    $decimal //= '';

    my $non_repeat;
    my $repeat;

    if ($decimal =~ /^([^()]*)\((\d+)\)$/) {
        $non_repeat = $1;
        $repeat     = $2;
    } else {
        $non_repeat = $decimal;
        $repeat     = '';
    }

    my $n = length($non_repeat);
    my $r = length($repeat);

    if ($r == 0) {
        my $den = 10**$n;
        my $num = $whole * $den + ($non_repeat || 0);

        return ($num, $den);
    }

    my $pow_n = 10**$n;
    my $pow_r = 10**$r;

    my $cycle = $pow_r - 1;
    my $den   = $pow_n * $cycle;

    my $num = $whole * $den + ($non_repeat || 0) * $cycle + $repeat;

    return ($num, $den);
}

sub rational_numbers {
    my $rat1 = shift;
    my $rat2 = shift;

    my ($num1, $den1) = _to_fraction($rat1);
    my ($num2, $den2) = _to_fraction($rat2);

    # Avoid floating-point division by cross multiplying.
    return $num1 * $den2 == $num2 * $den1;
}

for my $case (@cases) {
    my $got = rational_numbers($case->{rat1}, $case->{rat2});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
