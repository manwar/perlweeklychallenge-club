#!/usr/bin/env raku

sub myzip(@a, @b) {
	my @result;
	for zip(@a, @b) -> [$x, $y] { @result.push($x, $y) }
	return @result;
}

myzip(<a b c>, <1 2 3>).say;
myzip(<1 2 3>, <a b c>).say;
