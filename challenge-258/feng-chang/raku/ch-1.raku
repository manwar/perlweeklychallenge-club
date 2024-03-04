#!/bin/env raku

unit sub MAIN(*@ints);

put +@ints.grep(*.chars %% 2);
