#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.Bag.grep(*.value == 1).first.key;
