#!/usr/bin/env perl6
use v6;

sub iscol($n) {
    ((^$n.chars) X (^$n.chars)).grep({ $_[1] >= $_[0] }).map({ $n.substr($_[0]..$_[1]) }).map({ $_.split('',:skip-empty).reduce(&infix:<*>) }).unique.elems
    == $n.chars * ($n.chars+1) /2
}

say (100..999).grep(&iscol);

# run as <script>
