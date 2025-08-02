#!/usr/bin/env perl
#
=head1 Task 2: Nice String

Submitted by: Mohammad Sajid Anwar

You are given a string made up of lower and upper case English letters only.

Write a script to return the longest substring of the give string which is
nice. A string is nice if, for every letter of the alphabet that the string
contains, it appears both in uppercase and lowercase.

=head2 Example 1

    Input: $str = "YaaAho"
    Output: "aaA"

=head2 Example 2

    Input: $str = "cC"
    Output: "cC"

=head2 Example 3

    Input: $str = "A"
    Output: ""

    No nice string found.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["YaaAho", "aaA", "Example 1"],
    ["cC",     "cC",  "Example 2"],
    ["A",      "",    "Example 3"],
];

sub nice_string
{
    my $str = shift;

    my $max_len = 0;
    my $max_substr = '';
    my $len = length($str);
    for my $i (0 .. $len - 1) {
        for my $j ($i + 1 .. $len) {
            my $substr = substr($str, $i, $j - $i);
            my %seen;
            my $is_nice = 1;

            for my $char (split //, $substr) {
                if ($char =~ /[a-zA-Z]/) {
                    $seen{lc($char)}++;
                }
            }

            for my $key (keys %seen) {
                if ($seen{$key} < 2) {
                    $is_nice = 0;
                    last;
                }
            }

            if ($is_nice && length($substr) > $max_len) {
                $max_len = length($substr);
                $max_substr = $substr;
            }
        }
    }
    return $max_substr;
}

for (@$cases) {
    is(nice_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
