#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.map(*.abs).min;
