#!/usr/bin/env perl

use v5.36;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1

my @examples = qw/123 1234 100000 1000000 1 12345/;    
    
foreach my $input ( @examples ) {
    my $output = q{};

    # Split the numbers up into individual digits and store them,
    # in order, in an array
    my @digits = split( //, $input );

    # Use Perl's built-in length operator to filter out numbers
    # too small to require a thousands comma separator
    if ( length( $input ) < 4 ) {
	$output = $input;
    }

    # Since there are 3 different types of numbers to handle, we can
    # distinguish between them using the remainder from 
    # Perl's modulo division operator
    elsif ( scalar( @digits ) % 3 == 0 ) {

        # The posted example data for this challenge did not include
	# any numbers in this category, so I added one to make
	# sure the code was working as intended
        $output = thousand_separator( \@digits, 3 );
    }
    elsif ( scalar( @digits ) % 3 == 2 ) {
        $output = thousand_separator( \@digits, 2 );
    }
    else {
	# We do not require a test here, there is only one
	# option left
	$output = thousand_separator( \@digits, 1 );
    }

    print "Input: \$int = " . $input ."\n";
    print "Output: \"" . $output . "\"\n\n";
}    

# After inspection I realized that my initial solution could be 
# substantially shortened by creating one subroutine to do all
# of the heavy lifting

sub thousand_separator ( $digits, $divisor ) {
    my $output = q{};
    my $count = 0;
    foreach my $digit ( $digits->@* ) {

	# Each time through this loop we concatenate the current
	# digit onto the end of the number we are building up, and
	# then we autoincrement the counter
        $output .= $digit;
	$count++;

	# This test avoids printing an undesired terminal comma
	last if scalar( $digits->@* ) == $count;

	# For each digit in the array, test to see if it is time
	# to add a comma to the number we are building up
        if ( $count == $divisor or $count % 3 == $divisor ) {
            $output .= ',';
	}
    }
    return $output;
}
    

