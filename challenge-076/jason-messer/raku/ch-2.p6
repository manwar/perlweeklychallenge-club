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
		    for ( ((0,-1,1) X (0,-1,1))[1..*] ) -> $dir_offset {
			with cast_ray($dir_offset,$x, $y).grep( {.chars >= 4} ) { .say if .elems > 0 }
		    }
		}
	}
}

sub cast_ray($dir, $x is copy, Int $y is copy) {
	my @potential;
	my @found = gather
	loop (; (0 <= $x < @grid.elems) and (0 <= $y < @grid.first.elems); $x += $dir.first, $y += $dir.tail) {
		@potential.append: lc(@grid[$x][$y]);
		with @potential.join { .take if %dict{$_} }
	}
}
