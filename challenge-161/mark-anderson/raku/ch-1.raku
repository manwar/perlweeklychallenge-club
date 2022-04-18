#!/usr/bin/env raku

.say if [lt] .comb for 'dictionary.txt'.IO.lines ==> sort { $^b.chars <=> $^a.chars }
