#! /usr/bin/env raku

unit sub MAIN (*@args);

(@args[0].words, @args[1].words).Bag.grep({ .value == 1 }).map(*.key).sort.say;