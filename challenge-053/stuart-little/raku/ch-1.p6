#!/usr/bin/env perl6
use v6;

sub rot(@a,$a) {
    given $a {
	when 0 { @a }
	when 90 { @a[0].keys.map({ @a[0..^@a;$_] }).map(*.reverse) }
	when 180 { @a.reverse.map(*.reverse) }
	when 270 { rot(@a,90).reverse.map(*.reverse) }
    }
}

my @a=((1,2,3),(4,5,6),(7,8,9));

for rot(@a,@*ARGS[0]) {
    .say
}

# run as <script> <angle in degrees>
