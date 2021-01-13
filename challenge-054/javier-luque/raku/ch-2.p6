# Test: perl6 ch-2.p6
sub MAIN() {

    # Brute force calculate collatz
    my %lengths;
    for (1 .. 1_000_000) -> $i {
    	my $length = collatz($i);
    	%lengths{$i} = $length
    		if ($length > 440);
    }

    # Grab the 22 longest numbers
    my @keys = %lengths.keys.sort(
    	{ %lengths.{$^b} <=> %lengths.{$^a} }
    ).[0 .. 21];

    # Output the lengths
    for ( @keys ) -> $i {
    	say "$i : Length " ~ %lengths{$i};
    }
}

#Calculate collatz
sub collatz($n is copy) {
    my $length = 0;

    while ($n != 1) {
    	$length++;

    	$n = ($n % 2) ??
    		3 * $n + 1  !!
    		$n / 2;
    }

    return $length.Int;
}
