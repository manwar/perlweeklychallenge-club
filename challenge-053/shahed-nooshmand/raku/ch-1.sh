raku -e 'my @M = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]; .put for (@M = reverse(do @M[*;$_] for ^@M[0]) for ^(get() / 90 % 4 || 4))[*-1]'
