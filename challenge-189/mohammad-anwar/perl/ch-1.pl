#!/usr/bin/perl

=head1

Week 189:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #1: Greater Character

    You are given an array of characters (a..z) and a target character.

    Write a script to find out the smallest character in the given
    array lexicographically greater than the target character.

=cut

use v5.36;
use Test2::V0;

is greater_character('b', qw/e m u g/, 'b'), 'e', 'Example 1';
is greater_character('a', qw/d c e f/, 'a'), 'c', 'Example 2';
is greater_character('o', qw/j a r/  , 'o'), 'r', 'Example 3';
is greater_character('a', qw/d c a f/, 'a'), 'c', 'Example 4';
is greater_character('v', qw/t g a l/, 'v'), 'v', 'Example 5';

done_testing;

#
#
# METHOD

sub greater_character($t, @chars) {
    for (sort @chars) { return $_ if ord > ord $t }
    return $t;
}
