#!/usr/bin/env perl
#
=head1 Task 1: Largest Interval

Submitted by: Ali Moradi

You are given a positive integer.  Write a script that generates a sequence of
integers from 1 to given positive integer, filtering out any numbers that
contain repeating digits (e.g., 11, 99, 100, and 101 are excluded) and return
the biggest jump.

=head2 Example 1

    Input: $int = 20
    Output: 2

    Biggest jump between 10 and 12.

=head2 Example 2

    Input: $int = 110
    Output: 4

    Biggest jump between 98 and 102.

=head2 Example 3

    Input: $int = 500
    Output: 11

    Biggest jump between:
    a) 109 and 120 => 11
    b) 219 and 230 => 11
    c) 329 and 340 => 11
    d) 439 and 450 => 11

=head2 Example 4

    Input: $int = 2026
    Output: 105

    Biggest jump between 1098 and 1203.

=head2 Example 5

    Input: $int = 10000
    Output: 105

    The largest gap is 105, between 1098 and 1203. And again between 8796 and 8901.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {int =>    20, out =>   2, name => 'Example 1'}, 
    {int =>   110, out =>   4, name => 'Example 2'},
    {int =>   500, out =>  11, name => 'Example 3'},
    {int =>  2026, out => 105, name => 'Example 4'},
    {int => 10000, out => 105, name => 'Example 5'},
);

sub largest_interval
{
    my $int = shift;
    my $prev = 0;
    my $max = 0;

    for my $n (1 .. $int) {
        if ($n !~ /(\d).*\1/) {
            my $diff = $n - $prev;
            $max = $diff if $diff > $max;
            $prev = $n;
        }
    }
    return $max;
}

for my $case (@cases) {
    my $got = largest_interval($case->{int});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
