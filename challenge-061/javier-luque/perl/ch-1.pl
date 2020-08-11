#!/usr/bin/perl
# Test: ./ch-1.pl 30
use strict;
use warnings;
use feature qw /say/;

say max_product([ 2, 5, -1, 3 ]);

sub max_product {
    my $list = shift;

    # Index of the array that will return
    # the max product
    my $left  = 0;
    my $right = scalar(@$list);

    # Max product
    my $max_product = 1;

    # Loop through the list
    for (my $i = 0; $i < scalar(@$list); $i++ ) {
    	my $j = $i;

    	# Temp variable
    	my $current_product = 1;

    	# Loop through the list another time
    	while ($j < scalar(@$list)) {
    		$current_product =
    			$current_product * $list->[$j];

    		if ($current_product >= $max_product) {
    			$max_product = $current_product;
    			$left  = $i;
    			$right = $j;
    		}

    		$j++;
    	}
    }

    return '[' .
    	(join ', ', @{$list}[$left .. $right]) .
    	']' . ' which gives a maximum product of ' .
    	$max_product;
}
