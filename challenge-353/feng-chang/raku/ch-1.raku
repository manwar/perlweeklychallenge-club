#!/bin/env raku

unit sub MAIN(*@strs);

put @strs.map(+*.words).max;
