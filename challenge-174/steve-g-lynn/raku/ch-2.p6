#!/usr/bin/env raku

say &permutation2rank( (1,0,2) ); # 2
say &rank2permutation( (0,1,2), 1); # (0 2 1)

sub permutation2rank (@arry) {
	my @perms = @arry.sort.permutations;
	return @perms.keys.grep( {@perms[$_] eqv @arry} );
}

sub rank2permutation (@arry, $rank) {
	return @arry.sort.permutations[$rank];
}

