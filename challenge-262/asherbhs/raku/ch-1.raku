sub max-positive-negative(Int:D @ints --> Int:D) {
	my $pos = 0;
	my $neg = 0;
	for @ints {
		$pos++ when $_ > 0;
		$neg++ when $_ < 0;
	}
	return max $pos, $neg
}

say max-positive-negative Array[Int].new: -3, 1, 2, -1, 3, -2, 4;
say max-positive-negative Array[Int].new: -1, -2, -3, 1;
say max-positive-negative Array[Int].new: 1, 2;
