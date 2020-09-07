#!/usr/bin/env raku

sub MAIN($grid-path, $words-path) {
    my @found = [];
    my @words = (slurp $words-path).fc.lines;

    my @grid = (slurp $grid-path).fc.lines».words;
    my @rows = @grid.map: *.cache.join;
    my @columns = ([Z] @grid).map: *.cache.join;
    my @diagonals;
    for ^4 {
    	for ^@grid[0] {
    		my $i = $_;
    		@diagonals.push: [~] gather {
    			take .[$i++] // last for @grid;
    		}
    	}
    	@grid = ([Z] @grid)».reverse;
    }

    for @words -> $word {
    	@found.push: $word if (@rows | @columns | @diagonals).grep: *.contains: $word | $word.flip;
    }

    .put for @found;
}
