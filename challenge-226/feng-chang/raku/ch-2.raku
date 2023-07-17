#!/bin/env raku

unit sub MAIN(*@N);

put +@N.grep(*>0).unique;
