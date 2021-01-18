#!/usr/bin/env perl6
#
#
#       pal-n-done.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int:D $num is copy) ;

$num += 0;

say
$num ~~ m:ex/^ (.*) {} .? "{$0.flip}" $/ ?? 1
                                         !! 0 ;
