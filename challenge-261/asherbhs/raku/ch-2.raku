sub multiply-by-two(Int @ints, Int $start --> Int) {
	return $start ∈ @ints
		?? multiply-by-two(@ints, 2 * $start)
		!! $start
}

say multiply-by-two Array[Int].new(5, 3, 6, 1, 12), 3;
say multiply-by-two Array[Int].new(1, 2, 4, 3),     1;
say multiply-by-two Array[Int].new(5, 6, 7),        2;
