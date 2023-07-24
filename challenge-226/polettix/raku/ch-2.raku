#!/usr/bin/env raku
use v6;
sub MAIN (*@ints) { put @ints.unique.grep({$_}).elems }
