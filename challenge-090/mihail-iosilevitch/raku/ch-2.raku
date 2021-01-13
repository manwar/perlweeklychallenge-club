#!/usr/bin/env rakudo
use v6;

sub multiply(Int $a, Int $b --> Int) {
	if $b == 1 {
		$a;
	} else {
		multiply($a*2, ($b/2).floor) + ($b %% 2 ?? 0 !! $a);
	}
}
sub MAIN(Int $a, Int $b) {
	say multiply $a, $b;
}
