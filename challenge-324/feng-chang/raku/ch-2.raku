#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.combinations.map({ [+^] $_ }).sum;
