#!/bin/env raku

# it all comes down to how many factors of 5 you have in N!
sub MAIN(UInt $N) {
    my UInt $cnt = 0;
	my UInt $f5s = 5;

	while $f5s <= $N {
		$cnt += $N div $f5s;
		$f5s *= 5;
	}

	say "{$N}! has $cnt trailing zeros";
}
