#!/usr/bin/env raku
use v6;

# run <script> <number>

sub no1($nr) {
    $nr.chars==0 && return 0;
    ($nr.substr(0,1) eq '1') && return 9**($nr.chars-1);
    return ($nr.substr(0,1).Int-1) * 9**($nr.chars-1) + no1($nr.substr(1));
}

say((@*ARGS[0] !~~ m/1/) ?? (no1(@*ARGS[0])) !! (no1(@*ARGS[0])-1)) 
