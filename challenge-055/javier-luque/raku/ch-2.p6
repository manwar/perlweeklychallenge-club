# Test: perl6 ch-2.p6 4
sub MAIN(Int $n where * > 0) {
    [1 .. $n].permutations.grep({is-wave($_)}).join("\n").say;
}

# Is the array a wave
sub is-wave(@n) {
    my $is_wave = True;
    loop (my $i = 1; $i < @n.elems; $i++) {
    	if ( $i % 2 == 1 && @n[$i] >= @n[$i - 1] ||
    	     $i % 2 == 0 && @n[$i] <= @n[$i - 1] ) {;
    		$is_wave = False;
    		last;
    	}
    }
    return $is_wave;
}
