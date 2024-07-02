#!/bin/env raku

unit sub MAIN(*@hours);

put +@hours.combinations(2).grep(*.sum %% 24);
