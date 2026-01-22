#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More;

sub kolakoski {
	my($int) = @_;
	my $x = "";
	for my $i (1 .. $int) {
		my $d = $i % 2 ? 1 : 2;
		my $n = $i <= length $x ? substr($x, $i - 1, 1) : $d;
		#say "$i:", length $x, ":", substr($x, $i - 1, 1), ":$d:$n";
		$x .= $d x $n;
		#say $x;
	}
	#say $x;
	return $x;
}

sub kolakoski_1s {
	my($k) = kolakoski(@_);
	return scalar(() = ($k =~ /1+/g));
}

is(kolakoski_1s(4), 2, "Example 1"); #(1)(22)(11)(2) => 1221
is(kolakoski_1s(5), 3, "Example 2"); #(1)(22)(11)(2)(1) => 12211
is(kolakoski_1s(6), 3, "Example 3"); #(1)(22)(11)(2)(1)(22) => 122112
is(kolakoski_1s(7), 4, "Example 4"); #(1)(22)(11)(2)(1)(22)(1) => 1221121
is(kolakoski_1s(8), 4, "Example 5"); #(1)(22)(11)(2)(1)(22)(1)(22) => 12211212
# Actually works for <= 3 as well
is(kolakoski(1), "1", "kolakoski(1)");
is(kolakoski(2), "122", "kolakoski(2)");
is(kolakoski(3), "12211", "kolakoski(3)");
# As I suspected, the number of 1s as specified in the task is $int/2 rounded up
for my $i (1 .. 10000) {
	is(kolakoski_1s($i), int(($i + 1) / 2), "rounding test $i");
}
done_testing();

