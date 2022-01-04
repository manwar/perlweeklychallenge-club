#!/usr/bin/env raku

say (^Inf).grep(*.is-prime)[1e4];
