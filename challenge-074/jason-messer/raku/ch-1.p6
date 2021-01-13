#! /usr/bin/env rakudo

use v6;

my @A = [1, 2, 2, 3, 2, 4, 2];
my @B = [1, 3, 1, 2, 4, 5];

subset WholeNum of Int where * > -1;

sub majority(@a where .all ~~ WholeNum) {
	my $most = @a.classify( {state %count; ++%count{$_}} ).sort.tail;
	if $most.key > (@a.elems div 2) {
		return $most.value[0];
	} else {
		return -1
	}
}

multi MAIN() {
	say majority(@A);
	say majority(@B);
}

multi MAIN(*@a) {
	say majority(@a);
}

