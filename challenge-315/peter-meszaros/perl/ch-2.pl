#!/usr/bin/env perl
#
=head1 Task 2: Find Third

Submitted by: Mohammad Sajid Anwar

You are given a sentence and two words.

Write a script to return all words in the given sentence that appear in
sequence to the given two words.

=head2 Example 1

    Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
           $first = "my"
           $second = "favourite"
    Output: ("language", "too")

=head2 Example 2

    Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
           $first = "a"
           $second = "beautiful"
    Output: ("doll", "princess")

=head2 Example 3

    Input: $sentence = "we will we will rock you rock you.",
           $first = "we"
           $second = "will"
    Output: ("we", "rock")

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["Perl is a my favourite language but Python is my favourite too.", "my", "favourite"],
            ["language", "too"], "Example 1"],
    [["Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful"],
            ["doll", "princess"], "Example 2"],
    [["we will we will rock you rock you.", "we", "will"],
            ["we", "rock"], "Example 3"],
];

sub find_third
{
    my $sentence = $_[0]->[0];
    my $first    = $_[0]->[1];
    my $second   = $_[0]->[2];

    $sentence =~ s/[[:punct:]]//g;
    my @words = split /[[:space:]]+/, $sentence;
    my @result;
    for (my $i = 0; $i < $#words - 1; $i++) {
        if ($words[$i] eq $first && $words[$i + 1] eq $second) {
            push @result, $words[$i + 2];
        }
    }
    return \@result;
}

for (@$cases) {
    is(find_third($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
