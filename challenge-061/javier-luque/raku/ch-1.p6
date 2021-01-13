# Test: perl6 ch-1.p6
sub MAIN() {
    say max-product([ 2, 5, -1, 3 ]);
}

sub max-product(@list) {

    # Index of the array that will return
    # the max product
    my $left  = 0;
    my $right = @list.elems;

    # Max product
    my $max_product = 1;

    # Loop through the list
    for ^@list -> $i {
    	my $j = $i;

    	# Temp variable
    	my $current_product = 1;

    	# Loop through the list another time
    	while ($j < @list.elems) {
    		$current_product =
    			$current_product * @list[$j];

    		if ($current_product >= $max_product) {
    			$max_product = $current_product;
    			$left  = $i;
    			$right = $j;
    		}

    		$j++;
    	}
    }

    return '[' ~
    	@list[$left .. $right].join(', ') ~
    	']' ~ ' which gives a maximum product of ' ~
    	$max_product;;
}
