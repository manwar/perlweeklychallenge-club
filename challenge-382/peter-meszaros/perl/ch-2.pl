#!/usr/bin/env perl
#
=head1 Task 2: Replace Question Mark

Submitted by: Simon Green

You are given a string that contains only 0, 1 and ? characters.  Write a
script to generate all possible combinations when replacing the question marks
with a zero or one.

=head2 Example 1

    Input: $str = "01??0"
    Output: ("01000", "01010", "01100", "01110")

=head2 Example 2

    Input: $str = "101"
    Output: ("101")

=head2 Example 3

    Input: $str = "???"
    Output: ("000", "001", "010", "011", "100", "101", "110", "111")

=head2 Example 4

    Input: $str = "1?10"
    Output: ("1010", "1110")

=head2 Example 5

    Input: $str = "1?1?0"
    Output: ("10100", "10110", "11100", "11110")

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Algorithm::Combinatorics qw/variations_with_repetition/;

my @cases = (
    {str => "01??0",
    out  => ["01000", "01010", "01100", "01110"],
    name => 'Example 1'},
    {str => "101",
    out  => ["101"],
    name => 'Example 2'},
    {str => "???",
    out  => ["000", "001", "010", "011", "100", "101", "110", "111"],
    name => 'Example 3'},
    {str => "1?10",
    out  => ["1010", "1110"],
    name => 'Example 4'},
    {str => "1?1?0",
    out  => ["10100", "10110", "11100", "11110"],
    name => 'Example 5'},
);

sub replace_question_mark
{
    my $str = shift;
    my @str = split //, $str;
    my $result = [];

    my $k = grep { $_ eq '?' } @str;

    my $iter = variations_with_repetition([0, 1], $k);
    while (my $p = $iter->next) {
        my @str2 = @str;
        for my $i (0 .. $#str2) {
            $str2[$i] = shift @$p if $str2[$i] eq '?';
        }
        push @$result, join('', @str2);
    }
    return $result;
}

for my $case (@cases) {
    my $got = replace_question_mark($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
