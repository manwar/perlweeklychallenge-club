sub zero-friend (Int:D @nums) {
	@nums».abs.min
}

say zero-friend Array[Int].new: 4, 2, -1, 3, -2;
say zero-friend Array[Int].new: -5, 5, -3, 3, -1, 1;
say zero-friend Array[Int].new: 7, -3, 0, 2, -8;
say zero-friend Array[Int].new: -2, -5, -1, -8;
say zero-friend Array[Int].new: -2, 2, -4, 4, -1, 1;
