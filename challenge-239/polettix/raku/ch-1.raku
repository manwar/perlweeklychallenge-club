#!/usr/bin/env raku
use v6;
sub MAIN ($s1, $s2) { say is-same-string($s1.split(/\,/), $s2.split(/\,/)) }

sub is-same-string (@s1, @s2) { @s1.join('') eq @s2.join('') }
