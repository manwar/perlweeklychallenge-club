# Test: perl6 ch-2.p6

sub MAIN() {
	my @A = (2, 1, 4, 5, 3, 7);
	histogram(@A);
	say "Output: " ~ largest-rect(@A);

	say "\n";

	my @B = (3, 2, 3, 5, 7, 5);
	histogram(@B);
	say "Output: " ~ largest-rect(@B);
}

sub histogram(@A) {
	my $max = @A.max;

	for (reverse (1 ..$max)) -> $row {
		print "$row ";
		for (@A) -> $col {
			if ($col >= $row) {
				print "# ";
			} else {
				print "  ";
			}
		}
		print "\n";
	}

	print "- " x (@A.elems + 1) ~ "\n";
	print "  " ~ (join ' ', @A) ~ "\n";
}

sub largest-rect(@A) {
	my @stack;
	my $max_area = 0;
	my $stack_top;
	my $i = 0;

	while ($i < @A.elems) {
		if (!@stack.elems || @A[@stack[*-1]] <= @A[$i]) {
			@stack.push($i++);
		} else {
			$stack_top = @stack.pop;
			my $w = (@stack.elems) ??
				($i - @stack[*-1] - 1) !! $i;
			my $area = @A[$stack_top] * $w;
			$max_area = max($max_area, $area);
		}
	}

	while (@stack) {
		$stack_top = @stack.pop;
		my $w = (@stack.elems) ??
			($i - @stack[*-1] - 1) !! $i;
		my $area = @A[$stack_top] * $w;
		$max_area = max($max_area, $area);
	}

	return $max_area;
}
