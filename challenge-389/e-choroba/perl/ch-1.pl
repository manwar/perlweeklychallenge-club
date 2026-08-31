#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub reorder_notes($melody) {
    my ($composer, $notes, $order) = @$melody;
    my @reordered;
    $reordered[ $order->[$_] - 1 ] = $notes->[$_] for 0 .. $#$order;
    return join ' ', uc $composer, '=>', @reordered
}

use Test::More tests => 5;

no warnings 'qw';
is reorder_notes(['Bach', [qw[ C D E F# G A B ]], [7, 1, 6, 2, 5, 3, 4]]),
    'BACH => D F# A B G E C', 'Example 1';

is reorder_notes(['Beethoven', [qw[ C D F# G Ab ]], [1, 3, 5, 2, 4]]),
    'BEETHOVEN => C G D Ab F#', 'Example 2';

is reorder_notes([ 'Brahms', [qw[ C Db Eb F G Ab Bb C D ]],
                   [9, 3, 7, 1, 8, 5, 2, 6, 4] ]),
    'BRAHMS => F Bb Db D Ab C Eb G C', 'Example 3';

is reorder_notes([ 'Bruckner', [qw[ G F# Bb C D Eb F ]], [4, 7, 2, 6, 1, 5, 3] ]),
    'BRUCKNER => D Bb F G Eb C F#', 'Example 4';

is reorder_notes(['Berg', [qw[ C# ]], [1]]), 'BERG => C#', 'Example 5';
