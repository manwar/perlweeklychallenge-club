#!/usr/bin/env raku

unit sub MAIN ($file-with-words = '/usr/share/dict/words-insane');

$file-with-words.IO
andthen .lines().race
andthen .grep: {  $_ eq .comb.sort.join }\ #collate
andthen .max: *.chars
andthen .say
