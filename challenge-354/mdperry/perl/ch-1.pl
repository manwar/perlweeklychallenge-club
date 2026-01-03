#!/usr/bin/env perl

use v5.36;

my @inputs = ( [4, 2, 1, 3], [10, 100, 20, 30], [-5, -2, 0, 3], [8, 1, 15, 3], [12, 5, 9, 1, 15], );

foreach my $input ( @inputs ) {
    # Sorting the input is not required, but might help when debugging(?)
    my @sorted = sort {$a <=> $b} $input->@*; 

    # Let's use a hash to store the absolute minimum differences
    # between all of the pair combinations of numbers in each array.  The hash keys will be
    # the differences we calculate, and the hash value(s) will be an arrayref of the number pairs
    # that share the same absolute minimum difference
    my %number_pairs_of = ();
    foreach my $i (0..$#sorted) {

	# skip subtracting self from self, instead start with the
	# next array element 
        foreach my $j ($i+1..$#sorted) {
            my $abs_min_diff = $sorted[$j] - $sorted[$i];

	    # create an anonymous array containing the current pair, and push that onto
	    # the hash values arrayref
	    push(@{$number_pairs_of{$abs_min_diff}}, [$sorted[$i], $sorted[$j]]);
	}
    }	

    # Now, we extract the keys from the %number_pairs_of hash, and sort them numerically
    # to identify the minimum distance for this $input
    my @differences = sort {$a <=> $b} keys %number_pairs_of;

    # The smallest difference will be in the first array element, so use that as a hash key to
    # select all of the pairs that differ by that amount, and pretty print them to STDOUT
    foreach my $pair ( $number_pairs_of{$differences[0]}->@* ) {
        print "[$pair->[0], $pair->[1]] ";
    }
    print "\n\n";
}

