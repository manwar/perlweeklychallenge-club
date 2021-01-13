#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

sub f ( Int $n where * > 0 ) { [*] 1 .. $n }
sub zero-length-f-and-count ( Int $n where * > 0 ) {
    ( f($n) ~~ /0+$/ // '' ).chars;
}

sub zero-length-reduce ( Int $n where * > 0 ) {
    reduce { my $i = 0; ++$i while $^b %% 5**($i+1); $^a + $i }, 0 .. $n
}
sub MAIN ( Int \N where * > 0 ) {
    say "Where N  = {N}";
    say "      N! = {f(N)}";
    say "Counted: " ~ zero-length-f-and-count(N);
    say "Reduced: " ~ zero-length-reduce(N);
}
