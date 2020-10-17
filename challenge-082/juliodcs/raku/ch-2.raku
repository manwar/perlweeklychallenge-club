#!/usr/bin/env raku

sub interleaved($a is rw, $b is rw, $c is rw) {
    ($a, $b) .= reverse if $a.chars < $b.chars;
    my ($has-a, $has-b) = False, False;
    $c ~~ s/ $a {$has-a = True} | $b {$has-b = True} // for ^2;
    $c eq ｢｣ && ($has-a && $has-b || $a eq $b)
}

if (@*ARGS.elems == 3) {
    say +interleaved |@*ARGS;
    exit 0;
}

use Test;

plan 15;
my @params;

@params = 'A', 'B', 'BB';
ok !interleaved(|@params), 'missing char from a';
@params = 'A', 'B', 'AA';
ok !interleaved(|@params), 'missing char from b';
@params = 'A', 'B', 'XX';
ok !interleaved(|@params), 'missing char from a,b';

@params = 'A', 'B', 'AB';
ok interleaved(|@params), 'two letters v1';
@params = 'A', 'B', 'BA';
ok interleaved(|@params), 'two letters v2';
@params = 'B', 'A', 'AB';
ok interleaved(|@params), 'two letters v3';
@params = 'B', 'A', 'BA';
ok interleaved(|@params), 'two letters v4';

@params = 'A', 'A', 'AA';
ok interleaved(|@params), 'a=b';
@params = 'ABC', 'ABC', 'ABCABC';
ok interleaved(|@params), 'long a=b';
@params = 'AAA', 'AAA', 'AAAAAA';
ok interleaved(|@params), 'long a=b, single char';

@params = 'AB', 'C', 'ACB';
ok interleaved(|@params), 'ACB basket v1';
@params = 'C', 'AB', 'ACB';
ok interleaved(|@params), 'ACB basket v2';

@params = 'XY', 'X', 'XXY';
ok interleaved(|@params), 'Example 1';
@params = 'XXY', 'XXZ', 'XXXXZY';
ok interleaved(|@params), 'Example 2';
@params = 'YX', 'X', 'XXY';
ok !interleaved(|@params), 'Example 3';
