#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test2::V0;
use List::MoreUtils qw(uniq);

=pod

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

     Week 194:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-194

    Task 2: Frequency Equalizer
    Submitted by: Mohammad S Anwar
    You are given a string made of alphabetic characters only, a-z.

    Write a script to determine whether removing only one character can make the frequency of the remaining characters
    the same.

=cut

is(frequencyEqualizer('abbc'), 1, 'Test Case 1 Failed.');
is(frequencyEqualizer('xyzyyxz'), 1, 'Test Case 2 Failed.');
is(frequencyEqualizer('xzxz'), 0, 'Test Case 3 Failed.');

sub frequencyEqualizer {
    my ($string) = @_;

    my %frequency_character_map = ();
    $frequency_character_map{$_} += 1 for (split(//, $string));
    my @unique_frequencies = uniq(values(%frequency_character_map));

    return((scalar(@unique_frequencies) == 2 and abs($unique_frequencies[0] - $unique_frequencies[1]) == 1) ? 1 : 0);
}

done_testing();
