sub distribute-elements(Int:D @ints) {
	my @arr1 = @ints[0];
	my @arr2 = @ints[1];

}

say distribute-elements Array[Int:D].new: 2, 1, 3, 4, 5;
say distribute-elements Array[Int:D].new: 3, 2, 4;
say distribute-elements Array[Int:D].new: 5, 4, 3 ,8;
