#!/usr/bin/env raku

use Test;

my @examples = (
    {
        in  => ['Bach', ['C','D','E','F#','G','A','B'], [7,1,6,2,5,3,4]],
        out => "BACH => D F# A B G E C",
    },
    {
        in  => ['Beethoven', ['C','D','F#','G','Ab'], [1,3,5,2,4]],
        out => "BEETHOVEN => C G D Ab F#",
    },
    {
        in  => ['Brahms', ['C','Db','Eb','F','G','Ab','Bb','C','D'], [9,3,7,1,8,5,2,6,4]],
        out => "BRAHMS => F Bb Db D Ab C Eb G C",
    },
    {
        in  => ['Bruckner', ['G','F#','Bb','C','D','Eb','F'], [4,7,2,6,1,5,3]],
        out => "BRUCKNER => D Bb F G Eb C F#",
    },
    {
        in  => ['Berg', ['C#'], [1]],
        out => "BERG => C#",
    },
);

is reconstruct-melody(|$_<in>), $_<out> for @examples;

done-testing;

sub reconstruct-melody($composer, $notes, $perm) {
    my @reordered;
    @reordered[ $perm.map(* - 1) ] = @$notes;
    return "{$composer.uc} => {@reordered.join(' ')}";
}
