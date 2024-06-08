sub bitwise-or(Int:D @ints --> Bool:D) {
	@ints.map(* %% 2).sum ≥ 2
}

say bitwise-or Array[Int:D].new: 1, 2, 3, 4, 5;
say bitwise-or Array[Int:D].new: 2, 3, 8, 16;
say bitwise-or Array[Int:D].new: 1, 2, 5, 7, 9;
