#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.words.tail.chars;
