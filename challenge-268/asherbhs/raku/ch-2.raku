sub number-game(Int:D @ints --> Array:D[Int:D]) {
	@ints.sort.map({ |($^b, $^a) }).Array
}

say number-game Array[Int:D].new: 2, 5, 3, 4;
say number-game Array[Int:D].new: 9, 4, 1, 3, 6, 4, 6, 1;
say number-game Array[Int:D].new: 1, 2, 2, 3;
