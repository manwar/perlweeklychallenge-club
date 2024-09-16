sub order-game(@ints) {
	my @r = @ints;
	for ^log @r, 2 {
		@r.=pairs.=map({
			($^a.key %% 4
				?? &[min]
				!! &[max]
			)(
				$^a.value,
				$^b.value,
			)
		})
	}
	@r.head
}

say order-game (2, 1, 4, 5, 6, 3, 0, 2);
say order-game (0, 5, 3, 2);
say order-game (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8);
