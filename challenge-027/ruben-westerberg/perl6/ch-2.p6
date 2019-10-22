#!/usr/bin/env perl6

my @history;
my $value:=remembering(@history);
$value=4;
$value=10;
$value=100;
put "Current  value of variable: $value";
put "Historical Values: " , join " ",@history;


sub remembering (@history) {
	return-rw Proxy.new(
		FETCH => method () {@history[*-1]},
		STORE => method ($new) {;@history.push($new)}
	);
}

