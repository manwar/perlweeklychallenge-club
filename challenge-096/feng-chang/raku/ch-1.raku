#!/bin/env raku

multi MAIN(Str:D $S) { put $S.words.reverse.join(' ') }
multi MAIN(*@S)      { MAIN(@S.join(' ')) }
