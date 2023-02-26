#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put maximum-xor2(@args) }

sub maximum-xor (@array) { @array .combinations(2) .map({[+^] $_}) .max }
sub maximum-xor2 (@a) { @a.combinations(2).map(->($x,$y){$x +^ $y}).max }
