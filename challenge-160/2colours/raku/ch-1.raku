#!/usr/bin/env raku

constant %digit-names = 0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine';

my $n = prompt('Input: $n = ');
my @word-seq = ($n, { %digit-names{$_}.chars } ... 4).map({ %digit-names{$_} }).Slip, 'magic';
say "Output: {@word-seq.rotor(2 => -1).map(*.join(' is ')).join(', ').tc}.";