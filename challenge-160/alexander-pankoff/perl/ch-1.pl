#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #1 › Four Is Magic
# Submitted by: Mohammad S Anwar
#
# You are given a positive number, $n < 10.
#
# Write a script to generate english text sequence starting with the English cardinal representation of the given number, the word ‘is’ and then the English cardinal representation of the count of characters that made up the first word, followed by a comma. Continue until you reach four.
#
# Example 1:
#
# Input: $n = 5
# Output: Five is four, four is magic.
#
#
# Example 2:
#
# Input: $n = 7
# Output: Seven is five, five is four, four is magic.
#
#
# Example 3:
#
# Input: $n = 6
# Output: Six is three, three is five, five is four, four is magic.

run() unless caller();

sub run() {
    my ($N) = @ARGV;
    die "Expect a single digit positive number!\n" unless $N and $N =~ m/^\d$/;
    say four_is_magic($N);
}

sub four_is_magic($n) {
    ucfirst _four_is_magic($n);

}

sub _four_is_magic($n) {
    my %cardinal_representations = (
        1 => 'one',
        2 => 'two',
        3 => 'three',
        4 => 'four',
        5 => 'five',
        6 => 'six',
        7 => 'seven',
        8 => 'eight',
        9 => 'nine',
    );

    if ( $n == 4 ) {
        return 'four is magic.';
    }

    my $cardinal = $cardinal_representations{$n};
    my $length   = length $cardinal;

    return join( ', ',
        join( ' ', $cardinal, 'is', $cardinal_representations{$length} ),
        _four_is_magic($length) );
}
