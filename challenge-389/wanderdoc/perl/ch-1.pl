#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array [composer, notes, permutation], reconstruct the melody by using each permutation value as the destination position of the corresponding note. Use no explicit for, foreach, or while loops. Output each result as COMPOSER => reordered notes.

    ASSUMPTION: Input is valid; the notes array and permutation array have identical lengths, and the permutation contains each position from 1 to N exactly once.

Example 1

Input: $melody = ['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]
Output: BACH => D F# A B G E C

Note 1 (C)  moves to position 7.
Note 2 (D)  moves to position 1.
Note 3 (E)  moves to position 6.
Note 4 (F#) moves to position 2.
Note 5 (G)  moves to position 5.
Note 6 (A)  moves to position 3.
Note 7 (B)  moves to position 4.

Example 2

Input: $melody = ['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]
Output: BEETHOVEN => C G D Ab F#

Note 1 (C)  stays at position 1.
Note 2 (D)  moves to position 3.
Note 3 (F#) moves to position 5.
Note 4 (G)  moves to position 2.
Note 5 (Ab) moves to position 4.

Example 3

Input: $melody = [ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]
Output: BRAHMS => F Bb Db D Ab C Eb G C

Example 4

Input: $melody = [ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]
Output: BRUCKNER => D Bb F G Eb C F#

Example 5

Input: $melody = ['Berg', [qw(C#)], [1]]
Output: BERG => C#
=cut



use Test2::V0 -no_srand => 1;

{
     no warnings 'qw';
     is(reorder_notes(['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]),
          'BACH => D F# A B G E C', 'Example 1');
     is(reorder_notes([ 'Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]),
          'BEETHOVEN => C G D Ab F#', 'Example 2');
     is(reorder_notes([ 'Brahms', [qw(C Db Eb F G Ab Bb C D)], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]),
          'BRAHMS => F Bb Db D Ab C Eb G C', 'Example 3');
     is(reorder_notes([ 'Bruckner', [qw(G F# Bb C D Eb F)], [4, 7, 2, 6, 1, 5, 3] ]),
          'BRUCKNER => D Bb F G Eb C F#', 'Example 4');
     is(reorder_notes([ 'Berg', [qw(C#)], [1] ]),
          'BERG => C#', 'Example 5');
     done_testing();
}
sub reorder_notes
{
     my $melody = $_[0];
     my $author = $melody->[0];
     my $notes = $melody->[1]; 
     my $positions = $melody->[2]; 
     # my %pos;
     # @pos{map { $_ - 1 } @$positions} = @$notes;

     # return join(" => ", uc $author, join(" ", @pos{0 .. $#$positions}));
     my @pos;
     @pos[map { $_ - 1 } @$positions] = @$notes;
     return join(" => ", uc $author, join(" ", @pos));
}    
