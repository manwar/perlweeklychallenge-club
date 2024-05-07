sub magic-number(Int:D @x, Int:D @y --> Int:D) {
	@y.min - @x.min
}

say magic-number Array[Int:D].new(3, 7, 5), Array[Int:D].new(9, 5, 7);
say magic-number Array[Int:D].new(1, 2, 1), Array[Int:D].new(5, 4, 4);
say magic-number Array[Int:D].new(2),       Array[Int:D].new(5);
