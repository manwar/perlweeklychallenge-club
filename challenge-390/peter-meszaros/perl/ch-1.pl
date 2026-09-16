#!/usr/bin/env perl
#
=head1 Task 1: Decode String

Submitted by: Mohammad Sajid Anwar

You are given an encoded string.  Write a script to return the decoded string
of the given encoded string.  The encoding rule is: K[encoded_string], where
the encoded_string inside the square brackets is repeated exactly K > 0 times.

=head2 Example 1

    Input: $str = "2[3[a]]"
    Output: "aaaaaa"

    3[a]    => aaa
    2[3[a]] => aaa aaa

=head2 Example 2

    Input: $str = "10[a]"
    Output: "aaaaaaaaaa"

=head2 Example 3

    Input: $str = "a2[b]c3[d]e"
    Output: "abbcddde"

=head2 Example 4

    Input: $str = "2[a2[b]c]"
    Output: "abbcabbc"

=head2 Example 5

    Input: $str = "1[a]2[b3[c]]"
    Output: "abcccbccc"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "2[3[a]]",      out => "aaaaaa",     name => 'Example 1'},
    {str => "10[a]",        out => "aaaaaaaaaa", name => 'Example 2'},
    {str => "a2[b]c3[d]e",  out => "abbcddde",   name => 'Example 3'},
    {str => "2[a2[b]c]",    out => "abbcabbc",   name => 'Example 4'},
    {str => "1[a]2[b3[c]]", out => "abcccbccc",  name => 'Example 5'},
);

sub decode_string
{
    my $str = shift;

    my $stack = [];
    my $current_num = 0;
    my $current_str = '';

    for my $char (split //, $str) {
        if ($char =~ /\d/) {
            $current_num = $current_num * 10 + $char;
        } elsif ($char eq '[') {
            push @$stack, [$current_str, $current_num];
            $current_str = '';
            $current_num = 0;
        } elsif ($char eq ']') {
            my ($prev_str, $num) = @{pop @$stack};
            $current_str = $prev_str . ($current_str x $num);
        } else {
            $current_str .= $char;
        }
    }
    return $current_str;
}

for my $case (@cases) {
    my $got = decode_string($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
