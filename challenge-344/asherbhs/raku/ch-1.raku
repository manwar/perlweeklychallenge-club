sub array-form-compute(Int:D @ints, Int:D $x) {
	(@ints.join('') + $x).polymod(10 xx *).reverse
}

say array-form-compute Array[Int](   1, 2, 3, 4),   12;
say array-form-compute Array[Int](      2, 7, 4),  181;
say array-form-compute Array[Int](      9, 9, 9),    1;
say array-form-compute Array[Int](1, 0, 0, 0, 0), 9999;
say array-form-compute Array[Int](            0), 1000;
