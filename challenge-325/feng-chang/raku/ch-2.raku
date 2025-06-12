#!/bin/env raku

unit sub MAIN(*@ints);

put (^+@ints).map({ @ints[$_] - (@ints.tail(*-$_-1).first(* ≤ @ints[$_]) // 0) });
