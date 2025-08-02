sub middle-index(Int:D @ints --> Int:D) {
	my ($l, $r) = 0, @ints.sum;
	for @ints.kv -> $i, $n {
		$r -= $n;
		return $i if $l == $r;
		$l += $n;
	}
	-1
}

say middle-index Array[Int:D].new: 2, 3, -1, 8, 4;
say middle-index Array[Int:D].new: 1, -1, 4;
say middle-index Array[Int:D].new: 2, 5;
