#!/bin/env raku

unit sub MAIN(*@words);

put @words.head(*-1).map(*.substr(0,1)).join eq @words.tail;
