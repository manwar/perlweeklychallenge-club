use Test;

sub find-duplicate-and-missing (Int @numbers) {
	my @normalized = 1 .. @numbers.elems;
	for zip(@numbers, @normalized) -> @pair {
		return @pair if @pair[0] != @pair[1];
	}
	return -1;
}

is find-duplicate-and-missing(my Int @ = [ 1, 2, 2, 4 ]), [2, 3];
is find-duplicate-and-missing(my Int @ = [ 1, 2, 3, 4 ]), -1;
is find-duplicate-and-missing(my Int @ = [ 1, 2, 3, 3 ]), [3, 4];
is find-duplicate-and-missing(my Int @ = [ 1, 2, 3, 4, 5, 7, 7 ]), [7, 6];
