#!/usr/bin/env perl

use v5.38;

my @inputs = ( 4, 12, 20, 96, 100, );

# We want to start with the largest Fibonacci numbers
# and work our way down, testing as we go, so I
# manually inverted the array
my @fibos = qw/89 55 34 21 13 8 5 3 2 1/;

foreach my $test_number ( @inputs ) {
    # Save a copy of current input for subsequent pretty-printing
    my $int = $test_number;

    # Don't waste time testing Fibonacci numbers unless they are 
    # less than or equal to the current input
    my @filtered = grep { $_ <= $test_number } @fibos;

    # When we find Fibonacci numbers we want to use then
    # we will stash them in here
    my @used = ();

    foreach my $fib ( @filtered ) {
        # Watch out; the value stored in $test_number changes
	# each time we find another Fibonacci number
	# to use
        my $diff = $test_number - $fib;

	# First case: We found it, we're done; no need to test further
	# stash this Fibonacci number and then get out of this
	# inner foreach loop (so you can print the results for this input)
        if ( $diff == 0 ) {
            push( @used, $fib, );
	    last;
        }
	# Second case: This Fibonacci number was too large to be used
	# go get the next one, and keep searching
        elsif ( $diff < 0 ) {
            next;
        }
	# Third case: Implicitly, $diff contains a number
	# larger than zero
	else {
	    # Two things, reset the value in $test_number,
	    # replacing it with the value in $diff
	    # AND, stash this Fibonacci number in the @used array,
	    # it's a keeper
            $test_number = $diff;
  	    push( @used, $fib, );
        }
    }

    print "Input: \$int = $int\n";
    print "Output: ";
    print join(",", @used), "\n\n";
    print "$int => ";
    print join(" + ", @used), "\n\n";

}

exit;

