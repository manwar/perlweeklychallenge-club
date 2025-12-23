#!/bin/env raku

unit sub MAIN(*@bin);

put ([\~] @bin).map((*.parse-base(2) %% 5).lc).join(', ');
