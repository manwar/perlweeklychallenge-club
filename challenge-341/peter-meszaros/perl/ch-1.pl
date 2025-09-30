#!/usr/bin/env perl
#
=head1 Task 1: Broken Keyboard

Submitted by: Mohammad Sajid Anwar

You are given a string containing English letters only and also you are given
broken keys.

Write a script to return the total words in the given sentence can be typed
completely.

=head2 Example 1

    Input: $str = 'Hello World', @keys = ('d')
    Output: 1

    With broken key 'd', we can only type the word 'Hello'.

=head2 Example 2

    Input: $str = 'apple banana cherry', @keys = ('a', 'e')
    Output: 0

=head2 Example 3

    Input: $str = 'Coding is fun', @keys = ()
    Output: 3

    No keys broken.

=head2 Example 4

    Input: $str = 'The Weekly Challenge', @keys = ('a','b')
    Output: 2

=head2 Example 5

    Input: $str = 'Perl and Python', @keys = ('p')
    Output: 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [['Hello World',          ['d']],      1, "Example 1"],
    [['apple banana cherry',  ['a', 'e']], 0, "Example 2"],
    [['Coding is fun',        []],         3, "Example 3"],
    [['The Weekly Challenge', ['a','b']],  2, "Example 4"],
    [['Perl and Python',      ['p']],      1, "Example 5"],
];

sub broken_keyboard
{
    my $str  = $_[0]->[0];
    my $keys = $_[0]->[1];

    $str =~ s/$_/#/gi for @$keys;
    my $count = 0;
    for (split /\s+/, $str) {
        $count++ unless /#/;
    }

    return $count;
}

for (@$cases) {
    is(broken_keyboard($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
