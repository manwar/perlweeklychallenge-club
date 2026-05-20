#!/usr/bin/env perl
#
=head1 Task 2: Largest Same-digits Number

Submitted by: Mohammad Sajid Anwar

You are given a string containing 0-9 digits only. Write a script to return
the largest number with all digits the same in the given string.

=head2 Example 1

    Input: $str = "6777133339"
    Output: 3333

=head2 Example 2

    Input: $str = "1200034"
    Output: 4

=head2 Example 3

    Input: $str = "44221155"
    Output: 55

=head2 Example 4

    Input: $str = "88888"
    Output: 88888

=head2 Example 5

    Input: $str = "11122233"
    Output: 222

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["6777133339", 3333, "Example 1"],
    ["1200034",       4, "Example 2"],
    ["44221155",     55, "Example 3"],
    ["88888",     88888, "Example 4"],
    ["11122233",    222, "Example 5"],
];

sub largest_same_digits_number
{
    my $str = shift;
    my $largest = 0;
    my %digits;

    $digits{$_}++ for split //, $str;

    for my $d (keys %digits) {
        my $num = $d x $digits{$d};
        $largest = $num if $num > $largest;
    }

    return $largest;
}

for (@$cases) {
    is(largest_same_digits_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
