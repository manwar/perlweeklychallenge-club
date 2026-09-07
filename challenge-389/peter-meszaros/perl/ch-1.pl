#!/usr/bin/env perl
#
=head1 Task 1: Reorder Notes

Submitted by: Reinier Maliepaard

You are given an array [composer, notes, permutation], reconstruct the melody
by using each permutation value as the destination position of the
corresponding note. Use no explicit for, foreach, or while loops. Output each
result as COMPOSER => reordered notes.

ASSUMPTION: Input is valid; the notes array and permutation array have
identical lengths, and the permutation contains each position from 1 to N
exactly once.

=head2 Example 1

    Input: $melody = ['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]
    Output: BACH => D F# A B G E C

    Note 1 (C)  moves to position 7.
    Note 2 (D)  moves to position 1.
    Note 3 (E)  moves to position 6.
    Note 4 (F#) moves to position 2.
    Note 5 (G)  moves to position 5.
    Note 6 (A)  moves to position 3.
    Note 7 (B)  moves to position 4.

=head2 Example 2

    Input: $melody = ['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]
    Output: BEETHOVEN => C G D Ab F#

    Note 1 (C)  stays at position 1.
    Note 2 (D)  moves to position 3.
    Note 3 (F#) moves to position 5.
    Note 4 (G)  moves to position 2.
    Note 5 (Ab) moves to position 4.

=head2 Example 3

    Input: $melody = [ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]
    Output: BRAHMS => F Bb Db D Ab C Eb G C

=head2 Example 4

    Input: $melody = [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]
    Output: BRUCKNER => D Bb F G Eb C F#

=head2 Example 5

    Input: $melody = ['Berg', [qw(C#)], [1]]
    Output: BERG => C#

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {melody => ['Bach', ['C', 'D', 'E', 'F#', 'G', 'A', 'B'], [7, 1, 6, 2, 5, 3, 4]],
        out => [BACH => ['D', 'F#', 'A', 'B', 'G', 'E', 'C']], name => 'Example 1'},
    {melody => ['Beethoven', ['C', 'D', 'F#', 'G', 'Ab'], [1, 3, 5, 2, 4]],
        out => [BEETHOVEN => ['C', 'G', 'D', 'Ab', 'F#']], name => 'Example 2'},
    {melody => ['Brahms', ['C', 'Db', 'Eb', 'F', 'G', 'Ab', 'Bb', 'C', 'D'], [9, 3, 7, 1, 8, 5, 2, 6, 4]],
        out => [BRAHMS => ['F', 'Bb', 'Db', 'D', 'Ab', 'C', 'Eb', 'G', 'C']], name => 'Example 3'},
    {melody => ['Bruckner', ['G', 'F#', 'Bb', 'C', 'D', 'Eb', 'F'], [4, 7, 2, 6, 1, 5, 3]],
        out => [BRUCKNER => ['D', 'Bb', 'F', 'G', 'Eb', 'C', 'F#']], name => 'Example 4'},
    {melody => ['Berg', ['C#'], [1]],
        out => [BERG => ['C#']], name => 'Example 5'},
);

sub reorder_notes
{
    my $composer    = $_[0]->[0];
    my $notes       = $_[0]->[1];
    my $permutation = $_[0]->[2];

    my @result;
    @result[@$permutation] = @$notes;
    shift @result;

    return [uc $composer => \@result];
}

for my $case (@cases) {
    my $got = reorder_notes($case->{melody});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
