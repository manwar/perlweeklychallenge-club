#!/usr/bin/env perl
#
=head1 Task 1: Alternate Case

Submitted by: Mohammad Sajid Anwar

You are given a string containing an equal number of uppercase and lowercase
English letters.  Write a script to the minimum number of adjacent character
swaps needed to turn the given string into an alternate case string.

=head2 Example 1

    Input: $str = "aAbB"
    Output: 0

=head2 Example 2

    Input: $str = "AAbb"
    Output: 1

    Swap 1: "AbAb"

=head2 Example 3

    Input: $str = "AAAbbb"
    Output: 3

    Swap 1: "AAbAbb"
    Swap 2: "AbAAbb"
    Swap 3: "AbAbAb"

=head2 Example 4

    Input: $str = "aABb"
    Output: 1

    Swap 1: "aAbB"

=head2 Example 5

    Input: $str = "bBBAaa"
    Output: 2

    Swap 1: "BbBAaa"
    Swap 2: "BbBaAa"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "aAbB",   out => 0, name => 'Example 1'},
    {str => "AAbb",   out => 1, name => 'Example 2'},
    {str => "AAAbbb", out => 3, name => 'Example 3'},
    {str => "aABb",   out => 1, name => 'Example 4'},
    {str => "bBBAaa", out => 2, name => 'Example 5'},
);

sub swaps_to_pattern {
    my $str = shift;
    my $start_upper = shift;

    my @chars = split //, $str;
    my $swaps = 0;
    my $n = @chars;

    for my $i (0 .. $n - 1) {
        my $want_upper = ($i % 2 == 0) ? $start_upper : !$start_upper;

        my $j = $i;
        while ($j < $n) {
            my $is_upper = $chars[$j] =~ /[A-Z]/;
            last if $is_upper == $want_upper;
            $j++;
        }

        for (my $k = $j; $k > $i; $k--) {
            ($chars[$k], $chars[$k - 1]) = ($chars[$k - 1], $chars[$k]);
            $swaps++;
        }
    }

    return $swaps;
}

sub alternate_case
{
    my $str = shift;

    my $swaps_upper_first = swaps_to_pattern($str, 1);
    my $swaps_lower_first = swaps_to_pattern($str, 0);

    return $swaps_upper_first < $swaps_lower_first
        ? $swaps_upper_first
        : $swaps_lower_first;
}

for my $case (@cases) {
    my $got = alternate_case($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;

