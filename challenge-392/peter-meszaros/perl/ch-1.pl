#!/usr/bin/env perl
#
=head1 Task 1: Convert Palindrome

Submitted by: Mohammad Sajid Anwar

You are given a string. Write a script to convert the given string to
palindrome by adding characters in front of it.

=head2 Example 1

    Input: $str = "pinnipeds"
    Output: "sdepinnipeds"

=head2 Example 2

    Input: $str = "abcd"
    Output: "dcbabcd"

=head2 Example 3

    Input: $str = "bananas"
    Output: "sananabananas"

=head2 Example 4

    Input: $str = "dissident"
    Output: "tnedissident"

=head2 Example 5

    Input: $str = "cailliachs"
    Output: "shcailliachs"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "pinnipeds",  out => "sdepinnipeds",  name => 'Example 1'},
    {str => "abcd",       out => "dcbabcd",       name => 'Example 2'},
    {str => "bananas",    out => "sananabananas", name => 'Example 3'},
    {str => "dissident",  out => "tnedissident",  name => 'Example 4'},
    {str => "cailliachs", out => "shcailliachs",  name => 'Example 5'},
);

sub is_palindrome
{
    my ($str, $i, $j) = @_;
    while($i < $j) {
        return false unless substr($str, $i, 1) eq substr($str, $j, 1);
        ++$i;
        --$j;
    }
    return true;
}

sub convert_palindrome
{
    my $str = shift;

    my $cnt = 0;
    my $i = length($str) - 1;

    while($i >= 0 && not is_palindrome($str, 0, $i)) {
        --$i;
        ++$cnt;
    }

    return reverse(substr($str, -$cnt)) . $str;
}

for my $case (@cases) {
    my $got = convert_palindrome($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
