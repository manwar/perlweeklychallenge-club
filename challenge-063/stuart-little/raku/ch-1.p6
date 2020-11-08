#!/usr/bin/env perl6
use v6;
use MONKEY-SEE-NO-EVAL;

sub last_word($s,$r) {
    my $rx=EVAL($r);
    $s.split(/\s+/).reverse.first(* ~~ $rx)
}

last_word(|@*ARGS[0,1]).say

# run as <script> <quoted string> <singly-quoted regex in rx format>
# e.g. <script> "Don't match too much, Chet!" 'rx:i/ch.t/'
