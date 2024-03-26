sub count-equal-divisible(Int:D @ints, Int:D $k --> Int:D) {
	my $n = 0;
	for 0 ..^ @ints -> $i {
		for $i + 1 ..^ @ints -> $j {
			$n++ if @ints[$i] == @ints[$j] && ($i %% $k || $j %% $k)
		}
	}
	return $n
}

say count-equal-divisible Array[Int].new(3, 1, 2, 2, 2, 1, 3), 2;
say count-equal-divisible Array[Int].new(1, 2, 3),             1;
