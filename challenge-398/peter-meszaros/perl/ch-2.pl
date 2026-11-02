#!/usr/bin/env perl
#
=head1 Task 2: String Difference

Submitted by: Mohammad Sajid Anwar

You are given an array of equal length strings.  Write a script to find the
difference integer array of each word in the given array. There will be one
word with a different array; return that word.  Each words[i] can be converted
into a difference integer array difference[i] of length n - 1 where
difference[i][j] = words[i][j+1] - words[i][j]

=head2 Example 1

    Input: @words = ("ab", "bc", "cd", "zy")
    Output: "zy"

    "ab" => [1 - 0] = [1]
    "bc" => [2 - 1] = [1]
    "cd" => [3 - 2] = [1]
    "zy" => [24 - 25] = [-1]

=head2 Example 2

    Input: @words = ("cba", "fed", "azy")
    Output: "azy"

    "cba" => [1 - 2, 0 - 1] = [-1, -1]
    "fed" => [4 - 5, 3 - 4] = [-1, -1]
    "azy" => [25 - 0, 24 - 25] = [25, -1]

=head2 Example 3

    Input: @words = ("pop", "ada", "beb", "cfc")
    Output: "pop"

    "pop" => [14 - 15, 15 - 14] = [-1, 1]
    "ada" => [3 - 0, 0 - 3] = [3, -3]
    "beb" => [4 - 1, 1 - 4] = [3, -3]
    "cfc" => [5 - 2, 2 - 5] = [3, -3]

=head2 Example 4

    Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
    Output: "aaba"

    "aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
    "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
    "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
    "aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]

=head2 Example 5

    Input: @words = ("aceg", "bdfh", "cegi", "azbz")
    Output: "azbz"

    "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
    "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
    "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
    "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {words => ["ab", "bc", "cd", "zy"],         out => "zy",   name => 'Example 1'},
    {words => ["cba", "fed", "azy"],            out => "azy",  name => 'Example 2'},
    {words => ["pop", "ada", "beb", "cfc"],     out => "pop",  name => 'Example 3'},
    {words => ["aaaa", "zzzz", "mmmm", "aaba"], out => "aaba", name => 'Example 4'},
    {words => ["aceg", "bdfh", "cegi", "azbz"], out => "azbz", name => 'Example 5'},
);

sub string_difference
{
    my $words = shift;
    my %diffs;

    for my $word (@$words) {
        my @diff;
        for my $i (0 .. length($word) - 2) {
            push @diff, ord(substr($word, $i + 1, 1)) - ord(substr($word, $i, 1));
        }
        my $key = join(',', @diff);
        $diffs{$key} = exists $diffs{$key} ? undef : $word;
    }

    for my $key (keys %diffs) {
        return $diffs{$key} if defined $diffs{$key};
    }
}

for my $case (@cases) {
    my $got = string_difference($case->{words});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
