sub hamiltonian-cycle($n) {
	my @graph = do for 1 .. $n -> $x {
		do for 1 .. $n -> $y {
			$y - 1 if $_ == .floor given sqrt $x + $y
		}
	}

	sub dfs(@path) {
		my @next = |@graph[@path[* - 1]];
		return @path if @path == $n and 0 ∈ @next;
		(@next ∖ @path)
			.map({ dfs (|@path, .key) })
			.first(?*)
			orelse ()
	}

	1 «+« dfs (0,)
}

say hamiltonian-cycle 32;
say hamiltonian-cycle 15;
say hamiltonian-cycle 34;

