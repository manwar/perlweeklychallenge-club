#!/usr/bin/env perl
#
=head1 Task 1: String Alike

Submitted by: Mohammad Sajid Anwar

You are given a string of even length.

Write a script to find if the given string split into two halves of equal
lengths and they both have same number of vowels.

=head2 Example 1

    Input: $str = "textbook"
    Output: false

    1st half: "text" (1 vowel)
    2nd half: "book" (2 vowels)

=head2 Example 2

    Input: $str = "book"
    Output: true

    1st half: "bo" (1 vowel)
    2nd half: "ok" (1 vowel)

=head2 Example 3

    Input: $str = "AbCdEfGh"
    Output: true

    1st half: "AbCd" (1 vowel)
    2nd half: "EfGh" (1 vowel)

=head2 Example 4

    Input: $str = "rhythmmyth"
    Output: false

    1st half: "rhyth" (0 vowel)
    2nd half: "mmyth" (0 vowel)

=head2 Example 5

    Input: $str = "UmpireeAudio"
    Output: false

    1st half: "Umpire" (3 vowels)
    2nd half: "eAudio" (5 vowels)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["textbook",     false, "Example 1"],
    ["book",         true,  "Example 2"],
    ["AbCdEfGh",     true,  "Example 3"],
    ["rhythmmyth",   false, "Example 4"],
    ["UmpireeAudio", false, "Example 5"],
];

sub string_alike
{
    sub _vowel_count {
        my $s = shift;
        my $count = 0;
        $count++ while ($s =~ /[aeiou]/gi);
        return $count;
    };

    my $str = shift;

    my $len = length($str);
    return false if $len % 2 != 0;
    my $half = $len / 2;
    my $first_half_cnt  = _vowel_count(substr($str, 0, $half));
    my $second_half_cnt = _vowel_count(substr($str, $half));
    return true if $first_half_cnt > 0 && $first_half_cnt == $second_half_cnt;
    return false;
}

for (@$cases) {
    is(string_alike($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
