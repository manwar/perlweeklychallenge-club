sub target-array(Int:D @source, Int:D @indices --> Array[Int:D]) {
	my Int:D @target = [];
	for @source Z @indices -> ($x, $i) { @target.splice: $i, 0, $x }
	@target
}

say target-array Array[Int:D].new(0, 1, 2, 3, 4), Array[Int:D].new(0, 1, 2, 2, 1);
say target-array Array[Int:D].new(1, 2, 3, 4, 0), Array[Int:D].new(0, 1, 2, 3, 0);
say target-array Array[Int:D].new(1),             Array[Int:D].new(0);
