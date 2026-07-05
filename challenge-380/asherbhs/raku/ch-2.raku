sub reverse-degree(Str:D $str) {
	sum $str.comb.kv.map: {
		($^i + 1) × (26 - ($^x.ord - 'a'.ord))
	}
}

say reverse-degree 'z';
say reverse-degree 'a';
say reverse-degree 'bbc';
say reverse-degree 'racecar';
say reverse-degree 'zyx';
