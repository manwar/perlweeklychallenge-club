sub target-index(Int:D @ints, Int:D $k --> List) {
	@ints.sort.grep($k, :k).list
}

say target-index Array[Int].new(1, 5, 3, 2, 4, 2), 2;
say target-index Array[Int].new(1, 2, 4, 3, 5),    6;
say target-index Array[Int].new(5, 3, 2, 4, 2, 1), 4;
