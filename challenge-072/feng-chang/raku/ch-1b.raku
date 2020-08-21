#!/bin/env raku

sub MAIN(UInt $N) {
	say "{$N}! has { (([*] 1..$N) ~~ /(0*$)/).chars } trailing zeros";
}
