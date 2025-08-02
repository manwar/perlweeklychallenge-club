sub merge-items($items1, $items2) {
	$items1.append(|$items2)
		.classify(*[0], as => *[1])
		.map({ [.key, .value.sum] })
		.sort
		.Array
}

say merge-items
	[[1, 1], [2, 1], [3, 2]],
	[[2, 2], [1, 3]],
;
say merge-items
	[[1, 2], [2, 3], [1, 3], [3, 2]],
	[[3, 1], [1, 3]],
;
say merge-items
	[[1, 1], [2, 2], [3, 3]],
	[[2, 3], [2, 4]],
;
