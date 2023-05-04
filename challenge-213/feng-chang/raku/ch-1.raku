#!/bin/env raku

unit sub MAIN(*@N);

put (|@N.grep(* %% 2).sort, |@N.grep(* !%% 2).sort).join(', ');
