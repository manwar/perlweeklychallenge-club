sub third-maximum(Int:D @ints where @ints ≥ 1 --> Int:D) {
	@ints.unique.sort(&[Rcmp])[{$_ ≥ 3 ?? 2 !! 0}]
	#                         [  * ≥ 3 ?? 2 !! 0 ] would be nice, but alas
}

say third-maximum Array[Int](5, 6, 4, 1);
say third-maximum Array[Int](4, 5);
say third-maximum Array[Int](1, 2, 2, 3);
