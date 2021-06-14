#!/usr/bin/env raku
use v6;

# run <script> <number>

my @memo=[[''],['R','LH']];

sub mkPaths($size) {
    ($size >= @memo.elems) && do {
	my @res = mkPaths($size-1).map({ 'R' ~ $_ }).Array;
	for (0..^$size) -> $nr {
	    my @gluedPairs = (mkPaths($nr).Seq X mkPaths($size -1 - $nr).Seq).map({ 'L' ~ $_.[0] ~ 'H' ~ $_.[1] });
	    @res.push(|@gluedPairs);
	}
	@memo.push(@res.Array);
    };
    return @memo[$size];    
}

for (mkPaths(@*ARGS[0].Int).Seq) {
    .say;
}
