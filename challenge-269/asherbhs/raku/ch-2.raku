sub distribute-elements(Int:D @ints --> Array:D[Int:D]) {
	my @arr1 = @ints[0];
	my @arr2 = @ints[1];
	for @ints.tail(* - 2) -> $n {
		if @arr1[* - 1] > @arr2[* - 1] {
			@arr1.push($n)
		} else {
			@arr2.push($n)
		}
	}
	(|@arr1, |@arr2).Array
}

say distribute-elements Array[Int:D].new: 2, 1, 3, 4, 5;
say distribute-elements Array[Int:D].new: 3, 2, 4;
say distribute-elements Array[Int:D].new: 5, 4, 3 ,8;
