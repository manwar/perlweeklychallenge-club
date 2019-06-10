#!/usr/bin/env perl6

-> $a, $b { say "Equal point: " ~ ( $b - $a  == 100 ?? "None" !! $a / (1 - (($b - $a) / 100))) }(32,212)
