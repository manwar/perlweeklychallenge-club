#!/usr/bin/env raku
use Test;

is-deeply reorder-notes('Bach',      <C D E F# G A B>,        <7 1 6 2 5 3 4>),     'BACH'      => <D F# A B G E C>;
is-deeply reorder-notes('Beethoven', <C D F# G Ab>,           <1 3 5 2 4>),         'BEETHOVEN' => <C G D Ab F#>;
is-deeply reorder-notes('Brahms',    <C Db Eb F G Ab Bb C D>, <9 3 7 1 8 5 2 6 4>), 'BRAHMS'    => <F Bb Db D Ab C Eb G C>;
is-deeply reorder-notes('Bruckner',  <G F# Bb C D Eb F>,      <4 7 2 6 1 5 3>),     'BRUCKNER'  => <D Bb F G Eb C F#>;
is-deeply reorder-notes('Berg',      ('C#',),                 (1,)),                'BERG'      => ('C#',);

sub reorder-notes($composer, @notes is copy, @indices)
{
    @notes[@indices] = @notes;
    $composer.uc => @notes[1..*]
}
