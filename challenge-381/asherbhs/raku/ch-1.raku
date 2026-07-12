# couldn't get type annotations to work :/
sub same-row-column(@matrix) {
	my @ns = 1 .. +@matrix;
	[and] map @ns ≡ *, |@matrix, |[Z] @matrix
}

say same-row-column [[1, 2, 3, 4],
                     [2, 3, 4, 1],
                     [3, 4, 1, 2],
                     [4, 1, 2, 3]];
say same-row-column [[1,],];
say same-row-column [[1, 2, 5],
                     [5, 1, 2],
                     [2, 5, 1]];
say same-row-column [[1, 2, 3],
                     [1, 2, 3],
                     [1, 2, 3]];
say same-row-column [[1, 2, 3],
                     [3, 1, 2],
                     [3, 2, 1]];
