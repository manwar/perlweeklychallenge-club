#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Int Str);
use Test::More;

=head1 NAME

ch-1.pl - Longest Repeating Character

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 399, Task 1: Longest Repeating Character.
Given a string C<$str> and an integer C<$k>, finds the length of the longest
substring containing a single repeated character achievable by replacing at
most C<$k> characters.

=head1 FUNCTIONS

=head2 longest_repeating_character($str, $k)

Uses a sliding window over C<$str> to return the maximum substring length
obtainable with at most C<$k> character replacements.

=cut

signature_for longest_repeating_character => (
    method     => 0,
    positional => [ Str, Int ],
);

sub longest_repeating_character ( $str, $k ) {
    my @chars    = split //msx, $str;
    my %counts;
    my $left     = 0;
    my $max_freq = 0;
    my $best     = 0;

    for my $right ( 0 .. $#chars ) {
        my $ch = $chars[$right];
        $counts{$ch}++;
        $max_freq = $counts{$ch} if $counts{$ch} > $max_freq;

        while ( ( $right - $left + 1 ) - $max_freq > $k ) {
            $counts{ $chars[$left] }--;
            $left++;
        }

        my $win_len = $right - $left + 1;
        $best = $win_len if $win_len > $best;
    }

    return $best;
}

is( longest_repeating_character( 'AAAAA',     2 ), 5, 'Example 1' );
is( longest_repeating_character( 'ABCDE',     4 ), 5, 'Example 2' );
is( longest_repeating_character( 'AAABBBBAA', 1 ), 5, 'Example 3' );
is( longest_repeating_character( 'ABACADA',   2 ), 5, 'Example 4' );
is( longest_repeating_character( 'BAAABAAAA', 1 ), 8, 'Example 5' );
done_testing();
