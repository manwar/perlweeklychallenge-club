#!/usr/bin/env perl
#
=head1 Task 1: Word Break

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, and list of words, @words.

Write a script to return true or false whether the given string can be
segmented into a space separated sequnce of one or more words from the given
list.

=head2 Example 1

Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
Output: true

=head2 Example 2

Input: $str = "perlrakuperl", @words = ("raku", "perl")
Output: true

=head2 Example 3

Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
Output: false

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [['weeklychallenge',  ['challenge', 'weekly']],       1, 'Example 1'],
    [['perlrakuperl',     ['raku', 'perl']],              1, 'Example 2'],
    [['sonsanddaughters', ['sons', 'sand', 'daughters']], 0, 'Example 3'],
];

sub word_break
{
    my $w = $_[0]->[0];
    my $l = $_[0]->[1];

    $w =~ s/$_//g for @$l;

    return length($w) ? 0 : 1;
}

for (@$cases) {
    is(word_break($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
