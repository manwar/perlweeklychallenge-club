sub appearance(Int:D @ints --> Int) {
	my $len = 0.33 × @ints;
	my @keys = @ints.Bag.grep(*.value ≥ $len)».key;
	@keys ?? min @keys !! Int
}

say appearance Array[Int:D].new: 1, 2, 3, 3, 3, 3, 4, 2;
say appearance Array[Int:D].new: 1, 1;
say appearance Array[Int:D].new: 1, 2, 3;
say appearance Array[Int:D].new: 1, 2, 3, 4;
