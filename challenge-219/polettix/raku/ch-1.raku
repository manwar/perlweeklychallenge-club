#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { @args».².sort.join(', ').put }
