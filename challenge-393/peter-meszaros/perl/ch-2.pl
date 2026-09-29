#!/usr/bin/env perl
#
=head1 Task 2: Prime Step

Submitted by: Ulrich Rieke

You are given a string with English alphabetic characters only.  What is the
absolute difference of the sum of the ASCII values of the characters in the
string to the nearest prime number?

=head2 Example 1

    Input: $str = "hello"
    Output: 9

    The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
    The nearest prime number to 532 is 523, resulting in an absolute difference of 9.

=head2 Example 2

    Input: $str = "football"
    Output: 2

    Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
    We find 839 as the nearest prime number, so the difference is 2.

=head2 Example 3

    Input: $str = "a"
    Output: 0

=head2 Example 4

    Input: $str = "challenge"
    Output: 2

    The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103, 101], which sum up to 931.
    The nearest prime number to 931 is 929, so the difference is 2.

=head2 Example 5

    Input: $str = "perl"
    Output: 2

    The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
    Nearest prime is 433, so the difference is 2.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "hello",     out => 9, name => 'Example 1'},
    {str => "football",  out => 2, name => 'Example 2'},
    {str => "a",         out => 0, name => 'Example 3'},
    {str => "challenge", out => 2, name => 'Example 4'},
    {str => "perl",      out => 2, name => 'Example 5'},
);

sub is_prime
{
    my $n = shift;

    return false if $n < 2;
    return true  if $n == 2;
    return false if $n % 2 == 0;

    for (my $i = 3; $i <= sqrt($n); $i += 2) {
        return false if $n % $i == 0;
    }
    return true;
}

sub prime_step
{
    my $str = shift;

    my $sum = 0;
    $sum += ord($_) for (split //, $str);
    
    for (my $i = 0; ; $i++) {
        my $lower = $sum - $i;
        my $upper = $sum + $i;

        if (is_prime($lower)) {
            return abs($sum - $lower);
        }
        if (is_prime($upper)) {
            return abs($sum - $upper);
        }
    }
    return undef;
}

for my $case (@cases) {
    my $got = prime_step($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
