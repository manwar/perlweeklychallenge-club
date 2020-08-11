#!/usr/bin/env perl6

use v6;

say "ABBCDEEF".split(/<?before (.) {} :my $c=$0;><!after $c> /).perl("", "A", "BB", "C", "D", "EE", "F").Seq
