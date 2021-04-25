for 1 .. 20 -> $num {
	say [+] gather {
		for 1 ^.. ($num / 2).truncate -> $divisor {
			take $divisor if $num %% $divisor;
		}
	}
}
