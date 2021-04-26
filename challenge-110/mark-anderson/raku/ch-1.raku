#!/usr/bin/env raku

.say for "ch-1.txt".IO.lines

.grep(/ ^ [ \s\+\d\d | \(\d\d\) | \d\d\d\d ] \s \d**10 $ /);
