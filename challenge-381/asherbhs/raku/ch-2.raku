sub smaller-greater-element(@int) {
	my ($min, $max) = @int.min, @int.max;
	@int.grep($min < * < $max).elems
}

say smaller-greater-element (2, 4);
say smaller-greater-element (1, 1, 1, 1);
say smaller-greater-element (1, 1, 4, 8, 12, 12);
say smaller-greater-element (3, 6, 6, 9);
say smaller-greater-element (0, -5, 10, -2, 4);
