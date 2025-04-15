#!/usr/bin/env perl
#
=head1 Task 1: Acronyms

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a word.

Write a script to return true if concatenating the first letter of each word in
the given array matches the given word, return false otherwise.

=head2 Example 1

    Input: @array = ("Perl", "Weekly", "Challenge")
           $word  = "PWC"
    Output: true

=head2 Example 2

    Input: @array = ("Bob", "Charlie", "Joe")
           $word  = "BCJ"
    Output: true

=head2 Example 3

    Input: @array = ("Morning", "Good")
           $word  = "MM"
    Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["Perl", "Weekly", "Challenge"], "PWC"], 1, "Example 1"],
    [[["Bob", "Charlie", "Joe"],       "BCJ"], 1, "Example 2"], 
    [[["Morning", "Good"],              "MM"], 0, "Example 3"],
];

sub acronyms
{
    my ($words, $word) = @{$_[0]};

    return join('', map { substr($_, 0, 1) } @$words) eq $word ? 1 : 0;
}

for (@$cases) {
    is(acronyms($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
