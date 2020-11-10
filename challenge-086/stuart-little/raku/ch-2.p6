#!/usr/bin/env perl6
use v6;

my @bd=(
    < _ _ _ 2 6 _ 7 _ 1 >,
    < 6 8 _ _ 7 _ _ 9 _ >,
    < 1 9 _ _ _ 4 5 _ _ >,
    < 8 2 _ 1 _ _ _ 4 _ >,
    < _ _ 4 6 _ 2 9 _ _ >,
    < _ 5 _ _ _ 3 _ 2 8 >,
    < _ _ 9 3 _ _ _ 7 4 >,
    < _ 4 _ _ 5 _ _ 3 6 >,
    < 7 _ 3 _ 1 8 _ _ _ >,
).map(*.map({ $_.Str })).map(*.Array);

sub allow(@bd,($x,$y)) {
    (
	(1..9).map(*.Str) (-) @bd[$x]
	(-) @bd[0..*-1;$y]
	(-) @bd[($x div 3)*3..($x div 3)*3+2].map(*.[($y div 3)*3..($y div 3)*3+2])
    ).Hash.keys.sort
}

sub emptyrng(@a) {
    ((0..^@a) X (0..^@a)).grep({ @a[$_[0]][$_[1]].Str ne (1..9).any })
}

while (@bd.&emptyrng.grep({ @bd.&allow($_).elems == 1 }) ) {
    my ($x,$y)=@bd.&emptyrng.first({ @bd.&allow($_).elems == 1 });
    @bd[$x][$y]=@bd.&allow(($x,$y)).[0];
}

for (0..^@bd) {@bd[$_].say}

# run as <script>
