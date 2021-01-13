use v6.d;

my @matrix1 = qw/O O X/,
              qw/X O O/,
              qw/X O O/;

my @matrix2 = qw/O O X O/,
              qw/X O O O/,
	      qw/X O O X/,
	      qw/O X O O/;

sub find-no-neighbors(@a) {
    my @coords = gather for ^@a.elems -> $x {
	for ^@a[$x].elems -> $y {
	    next unless @a[$x][$y] eq 'X';
	    # all offsets, excluding 0,0
	    for ( ((0,1,-1) X (0,1,-1))[1..*] ) {
		state $neighbors = False;
		next unless 0 <= $x + .first < @a.elems;
		next unless 0 <= $y + .tail < @a[$x].elems;
		$neighbors = True if @a[$x + .first][$y + .tail] eq 'X';
		LAST { take $x => $y if !$neighbors }
	    }
	}
    }
    return @coords.elems;
}

say find-no-neighbors(@matrix1);
say find-no-neighbors(@matrix2);
