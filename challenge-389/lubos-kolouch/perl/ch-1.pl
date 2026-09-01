#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Reorder Notes
# Reconstruct the melody by using each permutation value as the destination
# position of the corresponding note without using explicit for, foreach, or while loops.

sub reorder_notes ($melody) {
    my ( $composer, $notes, $perm ) = @$melody;
    my @sorted_indices = sort { $perm->[$a] <=> $perm->[$b] } 0 .. $#$notes;
    my @reordered      = @{$notes}[@sorted_indices];
    return uc($composer) . ' => ' . join( ' ', @reordered );
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is(
        reorder_notes( [ 'Bach', [ 'C', 'D', 'E', 'F#', 'G', 'A', 'B' ], [ 7, 1, 6, 2, 5, 3, 4 ] ] ),
        'BACH => D F# A B G E C',
        'Example 1'
    );
    is(
        reorder_notes( [ 'Beethoven', [ 'C', 'D', 'F#', 'G', 'Ab' ], [ 1, 3, 5, 2, 4 ] ] ),
        'BEETHOVEN => C G D Ab F#',
        'Example 2'
    );
    is(
        reorder_notes( [ 'Brahms', [ 'C', 'Db', 'Eb', 'F', 'G', 'Ab', 'Bb', 'C', 'D' ], [ 9, 3, 7, 1, 8, 5, 2, 6, 4 ] ] ),
        'BRAHMS => F Bb Db D Ab C Eb G C',
        'Example 3'
    );
    is(
        reorder_notes( [ 'Bruckner', [ 'G', 'F#', 'Bb', 'C', 'D', 'Eb', 'F' ], [ 4, 7, 2, 6, 1, 5, 3 ] ] ),
        'BRUCKNER => D Bb F G Eb C F#',
        'Example 4'
    );
    is(
        reorder_notes( [ 'Berg', ['C#'], [1] ] ),
        'BERG => C#',
        'Example 5'
    );

    done_testing();
}
else {
    say reorder_notes( [ 'Bach', [ 'C', 'D', 'E', 'F#', 'G', 'A', 'B' ], [ 7, 1, 6, 2, 5, 3, 4 ] ] );
}
