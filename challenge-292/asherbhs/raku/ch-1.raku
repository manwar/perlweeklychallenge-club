sub twice-largest(@ints) {
	my ($i, $n) = @ints.max(:kv);
	@ints.map($n ≥ 2 × *).sum == @ints - 1 ?? $i !! -1
}

say twice-largest Array[Int].new: 2, 4, 1, 0;
say twice-largest Array[Int].new: 1, 2, 3, 4;
