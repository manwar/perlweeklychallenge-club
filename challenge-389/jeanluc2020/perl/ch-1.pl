#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-389/#TASK1
#
# Task 1: Reorder Notes
# =====================
#
# You are given an array [composer, notes, permutation], reconstruct the melody
# by using each permutation value as the destination position of the
# corresponding note. Use no explicit for, foreach, or while loops. Output each
# result as COMPOSER => reordered notes.
#
##    ASSUMPTION: Input is valid; the notes array and permutation array have
##    identical lengths, and the permutation contains each position from 1 to N
##    exactly once.
#
## Example 1
##
## Input: $melody = ['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]
## Output: BACH => D F# A B G E C
##
## Note 1 (C)  moves to position 7.
## Note 2 (D)  moves to position 1.
## Note 3 (E)  moves to position 6.
## Note 4 (F#) moves to position 2.
## Note 5 (G)  moves to position 5.
## Note 6 (A)  moves to position 3.
## Note 7 (B)  moves to position 4.
#
## Example 2
##
## Input: $melody = ['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]
## Output: BEETHOVEN => C G D Ab F#
##
## Note 1 (C)  stays at position 1.
## Note 2 (D)  moves to position 3.
## Note 3 (F#) moves to position 5.
## Note 4 (G)  moves to position 2.
## Note 5 (Ab) moves to position 4.
#
## Example 3
##
## Input: $melody = [ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]
## Output: BRAHMS => F Bb Db D Ab C Eb G C
#
## Example 4
##
## Input: $melody = [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]
## Output: BRUCKNER => D Bb F G Eb C F#
#
## Example 5
##
## Input: $melody = ['Berg', [qw(C#)], [1]]
## Output: BERG => C#
#
############################################################
##
## discussion
##
############################################################
#
# We need to loop somehow, so we use map() on the possible indices
# in the two arrays. We just need to map everything into an output
# array. Since the permutation gives a 1-based array, we add an
# unnecessary element to the output array first, which we then
# remove before the final output.

use v5.36;

reorder_notes(['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]);
reorder_notes(['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]);
reorder_notes([ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]);
reorder_notes([ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]);
reorder_notes(['Berg', [qw(C#)], [1]]);

sub reorder_notes($melody) {
    my ($composer, $notes, $permutation) = @$melody;
    my @P = @$permutation;
    my @out = ("X");
    map { $out[$permutation->[$_]] = $notes->[$_] } 0..$#P;
    shift @out;
    say "Output: " . uc($composer) . " => " . join(" ", @out);
}
