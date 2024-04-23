use v5.38;
sub A($m, $n) {
    if ($m == 0) {
	return $n + 1;
    } elsif ($n == 0) {
	return A($m - 1, 1);
    } else {
	return A($m - 1, A($m, $n - 1));
    }
}

say A(1,2);
