#!/usr/bin/env raku

.say if [le] .comb for 'dictionary.txt'.IO.lines ==> sort { -.chars }
