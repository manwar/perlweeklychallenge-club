#!/usr/bin/perl

=head1

Week 150:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-150

Task #1: Fibonacci Words

    You are given two strings having same number of digits, $a and $b.

    Write a script to generate Fibonacci Words by concatenation of the previous two strings. Finally print 51st digit of the first term having at least 51 digits.

=cut

use strict;
use warnings;
use Test::More;

is(fibonacci_words('1234', '5678', 51), 7, 'Example');

done_testing;

#
#
# METHOD

sub fibonacci_words {
    my ($term_1, $term_2, $index) = @_;

    while (length($term_1 . $term_2) <= $index) {
        ($term_1, $term_2) = ($term_2, $term_1 . $term_2);
    }

    return substr($term_1 . $term_2, --$index, 1);
}
