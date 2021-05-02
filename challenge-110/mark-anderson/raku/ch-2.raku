#!/usr/bin/env raku

say .map(*.join(",")).join("\n") given 
    
[Z] "ch-2.txt".IO.lines.map(*.split(",")); 
