#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=head1 NAME

ch-2.pl - Most Frequent Letter Pair

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 247, Task 2: Most Frequent Letter Pair.
Finds the consecutive two-letter substring that appears most frequently
in a given string, breaking ties lexicographically.

=head1 FUNCTIONS

=head2 most_frequent_letter_pair($s)

Counts all overlapping two-character substrings in C<$s> and returns the
most frequent pair, or the lexicographically smallest pair in case of a tie.

=cut

signature_for most_frequent_letter_pair => (
    method     => 0,
    positional => [Str],
);

sub most_frequent_letter_pair ($s) {
    return q{} if length($s) < 2;

    my %pairs;
    $pairs{ substr $s, $_, 2 }++ for 0 .. length($s) - 2;

    my ($best) = sort { $pairs{$b} <=> $pairs{$a} || $a cmp $b } keys %pairs;
    return $best;
}

is( most_frequent_letter_pair('abcdbca'),           'bc', 'Example 1' );
is( most_frequent_letter_pair('cdeabeabfcdfabgcd'), 'ab', 'Example 2' );
done_testing();
