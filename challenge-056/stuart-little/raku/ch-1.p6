#!/usr/bin/env perl6
use v6;

sub diffk($k,@a) {
    (&{$_}, &{$_.map(*.reverse)}).map({|@a.keys.combinations(2).$_}).grep({ @a[$_[0]]-@a[$_[1]] == $k }) || "nothing"    
}

say diffk(@*ARGS[0].Int, @*ARGS[1..*].map(*.Int))

# run as <script> <target difference $k> <space-separated array entries>
