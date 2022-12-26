#!/bin/env raku

unit sub MAIN(*@N);

put @N».Int.grep(* %% 2).BagHash.sort({ -.value, .key }).first.key // -1;
