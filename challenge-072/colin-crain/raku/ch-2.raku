#!/usr/bin/env perl6
# 
#       flippity-floppity.raku
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

subset Cardinal of Int where * > 0;

unit sub MAIN ( Cardinal $from = 3, 
                Cardinal $to = 6, 
                Str $file = $*PROGRAM-NAME);
    
## iterate through lines of $file as (key, value) pairs,
## output if line number flip-flop over $from to $to
## line numbers are indexes and are 0-based so we need to correct

.value.say if .key == $from-1 ff .key == $to-1 for $file.IO.lines.pairs;

