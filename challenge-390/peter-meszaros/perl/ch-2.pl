#!/usr/bin/env perl
#
=head1 Task 2: Order Characters

Submitted by: Mohammad Sajid Anwar

You are given a string $s (containing only alphabetic characters) and an
integer $k > 0.  Write a script to choose one of the first $k letters of given
string and append it at the end of the string. You keep doing this until you
have lexicographically smallest string and return the string.

=head2 Example 1

    Input: $str = "dbca", $k = 1
    Output: "adbc"

    Move 1: "bcad"
    Move 2: "cadb"
    Move 3: "adbc"

=head2 Example 2

    Input: $str = "geeks", $k = 2
    Output: "eegks"

    First 2 letters: "g", "e"

    Move 1: "gekse" (move second letter "e")
    Move 2: "gksee" (move second letter "e")
    Move 3: "kseeg"
    Move 4: "seegk"
    Move 5: "eegks"

=head2 Example 3

    Input: $str = "cbaed", $k = 3
    Output: "abcde"

    First 3 letters: "c", "b", "a"

    Move 1: "cbeda"  (move "a")
    Move 2: "cedab"  (move "b")
    Move 3: "edabc"  (move "c")
    Move 4: "eabcd"  (move "d")
    Move 5: "abcde"  (move "e")

=head2 Example 4

    Input: $str = "fedcba", $k = 4
    Output: "abcdef"

    First 4 letters: "f", "e", "d", "c"

    Move 1: "fdcbae" (move "e")
    Move 2: "dcbaef" (move "f")
    Move 3: "dcbefa" (move "a")
    Move 4: "dcefab" (move "b")
    Move 5: "defabc" (move "c")
    Move 6: "efabcd" (move "d")
    Move 7: "fabcde" (move "e")
    Move 8: "abcdef" (move "f")

=head2 Example 5

    Input: $str = "perl", $k = 1
    Output: "erlp"

    Move 1: "erlp" (move "p")

=head2 Example 6

    Input: $str = "oloolooo", $k = 1
    Output: "looloooo"

=head2 Example 7

    Input: $str = "oloooolo", $k = 1
    Output: "looloooo"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "dbca",     k => 1, out => "adbc",     name => 'Example 1'},
    {str => "geeks",    k => 2, out => "eegks",    name => 'Example 2'},
    {str => "cbaed",    k => 3, out => "abcde",    name => 'Example 3'},
    {str => "fedcba",   k => 4, out => "abcdef",   name => 'Example 4'},
    {str => "perl",     k => 1, out => "erlp",     name => 'Example 5'},
    {str => "oloolooo", k => 1, out => "looloooo", name => 'Example 6'},
    {str => "oloooolo", k => 1, out => "looloooo", name => 'Example 7'},
);

sub order_characters
{
    my ($str, $k) = @_;

    return undef if $k < 1 || $k > length($str);

    return join('', sort split //, $str) if $k > 1;

    my $len = length($str);
    my $smallest = $str;
    while (--$len) {
        $str = substr($str, 1) . substr($str, 0, 1);
        $smallest = $str if $str lt $smallest;
    }
    return $smallest
}

for my $case (@cases) {
    my $got = order_characters($case->{str}, $case->{k});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
