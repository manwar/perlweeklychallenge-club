#!/bin/env raku

unit sub MAIN(*@words);

put @words.map({ m/^\d+$/ ?? +$_ !! .chars }).max;
