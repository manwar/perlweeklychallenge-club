#! /usr/bin/env rakudo

my @grid;
my %dict;

sub MAIN($dict) {
	my $grid_fh = open :r, 'grid.txt' or die($grid_fh);
	my @lines = $grid_fh.lines();
	loop (my $i = 0; $i < @lines.elems; $i++) {
		@grid[$i] = @lines[$i].comb.map( {.lc} );
	}

	my $dict_fh = open :r, $dict or die($dict_fh);
	for $dict_fh.lines() -> $line {
		%dict{$line} = True;
	}
	for ^@grid.elems -> $x {
		for ^@grid[$x].elems -> $y {
			with cast_nw($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_n($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_ne($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_e($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_se($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_s($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_sw($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
			with cast_w($x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
		}
	}
}

# (-1, -1) #nw
sub cast_nw($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $x > 0 and $y > 0; $x--, $y--) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (-1,  0), #n
sub cast_n($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $x > 0; $x--) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (-1,  1), #ne
sub cast_ne($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $x > 0 and $y < @grid.first.elems; $x--, $y++) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (0,   1), #e
sub cast_e($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $y < @grid.first.elems; $y++) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (1,   1), #se
sub cast_se($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $x < @grid.elems and $y > @grid.first.elems; $x++, $y++) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (1,   0), #s
sub cast_s($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $x < @grid.elems; $x++) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (1,  -1), #sw
sub cast_sw($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $x < @grid.elems and $y > 0; $x++, $y--) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

# (0,  -1), #w
sub cast_w($x is copy, Int $y is copy) {
	my @potential;
	my @found = gather loop (; $y > 0; $y--) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}

