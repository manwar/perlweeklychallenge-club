sub element-digit-sum(Int @ints --> Int) {
	return abs @ints.sum - @ints».polymod(10 xx ∞)».sum.sum
}

say element-digit-sum Array[Int].new(1, 2, 3, 45);
say element-digit-sum Array[Int].new(1, 12, 3);
say element-digit-sum Array[Int].new(1, 2, 3, 4);
say element-digit-sum Array[Int].new(236, 416, 336, 350);
