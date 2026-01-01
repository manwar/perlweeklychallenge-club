#!/usr/bin/env perl

use v5.36;
use Data::Dumper;

my @inputs = ( [[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[10, 20], [30, 40]], [[1, 2], [3, 4], [5, 6]], [[1, 2, 3], [4, 5, 6]], [[1, 2, 3, 4]] );

# These are the k values for the number of times we are going to shift each grid:
my @integers = ( 1, 1, 1, 5, 1 );

foreach my $matrix ( @inputs ) {
    my @matrix = $matrix->@*;

    # Each time through the loop we use the next "k", and remove it from the array
    my $k = shift @integers;

    # Initialize a variable we'll need soon, using Perl Best Practices syntax
    # (Am I the only Perl hacker in the world that uses this syntax for ''?)
    my $output = q{};

    # There are five Example matrices provided for this task.  Four of them get shifted once
    # but one Example gets shifted more than once.  To handle two different cases
    # use a conditional test, coupled with two alternative code blocks.
    # I assume a more skilled software developer would design the
    # subroutine to call itself recursively.
    if ( $k > 1 ) {

	# If we want to shift the matrix more than once, then we are going to use
        # a for loop with a counter variable and just keep feeding the output from the
	# previous subroutine call, into the input for the next subroutine call, until we
	# use up all the numbers
        for my $i (1..$k) {
 	    my $new_matrix = shift_grid( \@matrix );
            @matrix = $new_matrix->@*;
        }
    }
    else {
        $output = shift_grid( \@matrix );
        @matrix = $output->@*;
    }	

    # The output from each example gets printed to STDOUT
    print Data::Dumper->new([\@matrix],[qw(*matrix)])->Indent(0)->Quotekeys(0)->Dump, "\n\n";
}

sub shift_grid ( $matrix ) {
    my @matrix = $matrix->@*;

    # For each matrix we use the Perl pop function to strip
    # off the terminal element of each array, and we are going to store those popped
    # values in this array (in order, we need to keep track of them)
    my @popped = ();

    # This loop pops them off and then stashes the contents them in the array
    foreach my $row ( @matrix ) {
        my $pop = pop $row->@*;
        push( @popped, $pop );
    }

    foreach my $row (0..$#matrix) {

	# Now we are going to use the Perl unshift function to
	# "paste" those popped array values onto the front of our
	# collection of shortened arrays.  But we wanted to keep
	# track because there are two different types of arrays:
	# The first one, and all the rest
	if ($row == 0 ) {

	    # IF: the $row we are processing is the FIRST $row
	    # THEN: we use the array index from the terminal arrayref
	    # to select the last value we added to the @popped array
	    # That is what we paste onto the front of the "shifted"
	    # grid:
            unshift $matrix->[$row]->@*, $popped[$#matrix];
	}
	else {

	    # Otherwise, we want the popped value from the previous $row
	    # to paste onto the front of this $row (this is to satisfy all
	    # three of the the rules)
            unshift $matrix->[$row]->@*, $popped[$row - 1];
	}
    }
    return \@matrix;
} 

