# Test: perl6 ch-1.p6
multi MAIN() {
    my @N = (2, 7, 9);
    my $k = 2;

    loop (my $i = 0; $i < @N.elems; $i++) {
    	loop (my $j = 0; $j < @N.elems; $j++) {
    		next if $i == $j;
    		say "$i, $j" if (@N[$i] - @N[$j] == $k);
    	}
    }
}
