#!/usr/bin/env perl
#
=head1 Task 2: Words Length Product

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.  Write a script to return the maximum value
of len($words[i]) * len($words[j]) where the two words do not share common
letters. If no such two words exist, return 0.

=head2 Example 1

    Input: @words = ("a", "ab", "abc", "d", "de", "def")
    Output: 9

    Two words are "abc" and "def".

=head2 Example 2

    Input: @words = ("a", "aa", "aaa", "aaaa")
    Output: 0

    Since no two words can be chosen without sharing letters, the result is 0.

=head2 Example 3

    Input: @words = ("meet", "app", "code", "sky", "bold")
    Output: 16

    Two words are "meet" and "bold".

=head2 Example 4

    Input: @words = ("a", "ab", "abc", "abcd", "efghi")
    Output: 20

    Two words are "abcd" and "efghi".

=head2 Example 5

    Input: @words = ("xyz", "w", "abcdefg", "hij")
    Output: 21

    Two words are "abcdefg" and "hij".

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {words => ["a", "ab", "abc", "d", "de", "def"],   out =>  9, name => 'Example 1'},
    {words => ["a", "aa", "aaa", "aaaa"],             out =>  0, name => 'Example 2'},
    {words => ["meet", "app", "code", "sky", "bold"], out => 16, name => 'Example 3'},
    {words => ["a", "ab", "abc", "abcd", "efghi"],    out => 20, name => 'Example 4'},
    {words => ["xyz", "w", "abcdefg", "hij"],         out => 21, name => 'Example 5'},
);

sub has_common_letters
{
    my ($word1, $word2) = @_;

    my %letters = map { $_ => 1 } split //, $word1;

    for my $l (split //, $word2) {
        return true if exists $letters{$l};
    }

    return false;   
}

sub words_length_product
{
    my $words = shift;
    my $max_product = 0;

    for (my $i = 0; $i < @$words; $i++) {
        for (my $j = $i + 1; $j < @$words; $j++) {
            my $word1 = $words->[$i];
            my $word2 = $words->[$j];

            unless (has_common_letters($word1, $word2)) {
                my $product = length($word1) * length($word2);
                $max_product = $product if $product > $max_product;
            }
        }
    }

    return $max_product;
}

for my $case (@cases) {
    my $got = words_length_product($case->{words});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
