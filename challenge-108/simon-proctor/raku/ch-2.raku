#!/usr/bin/env raku

#| Print the first X Bell numbers
sub MAIN (
    Int $x = 10 #= Amount of Bell numbers to calculate
) {
    my @bell-list = lazy gather {
	my @cur = [1];
	loop {
	    take @cur[0];
	    my @next = [ @cur[*-1] ];
	    for (0..^@cur.elems) -> $i {
		@next[$i+1] = @next[$i] + @cur[$i];
	    }
	    @cur = @next;
	}
    }
        
    .say for @bell-list[0..$x-1];
}

