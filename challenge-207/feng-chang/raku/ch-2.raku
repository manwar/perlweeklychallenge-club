#!/bin/env raku

unit sub MAIN(*@N);

put (+@N...1).first(-> \m { @N.grep(* ≥ m) ≥ m });
