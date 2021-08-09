#!/usr/bin/env raku
use v6;

# run <script> <number>

sub trps($n) {
    my @triples;
    @triples.push(| (1..(($n+1)/2).floor).map({ [$_, sqrt($n**2-$_**2).floor, $n] }).grep({ $_.[0] && $_.[1] && $_.[1]**2 == $n**2-$_.[0]**2 }) );
    @triples.push(| (1..$n-1).grep({ ($n**2 %% $_) && ($_%2 == ($n**2/$_).floor%2) }).map({ my $s = ($n**2/$_).floor; my $a = (($s-$_)/2).floor; my $b = (($s+$_)/2).floor; [$a,$n,$b] }) );
    return @triples;
}

my @sol=trps(@*ARGS[0].Int);
(@sol.elems) && do {
    for (@sol) {
	.say;
    }
    exit;
};

say -1;
