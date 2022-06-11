#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 20;

printf(
    "\nf(%d)=[%s]\n\n",
    $n,
    join(", ", calculate_fibonacci_digit_sums($n))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the first N numbers whose digits add up to a Fibonacci number
# Takes one argument:
# * An integer count N of numbers desired
# Returns on succes:
# * A list of the first N numbers whose digits add up to a Fibonacci number
# Returns on error:
# * undef if N isn't greater than or equal to 1
# NOTE: 0 and 1 are considered Fibonacci numbers for the purposes of this
# calculation
################################################################################
sub calculate_fibonacci_digit_sums{
    my $n = int(shift());

    return(undef)
        unless($n >= 1);

    # Populate this with the first couple
    # Fibonacci numbers
    my %fibs = (
        0 => 1,
        1 => 1
    );
    my @fib_digit_sums = ();
    my $fib_a = 1;
    my $fib_b = 1;
    my $fib_c;
    my $i = 0;

    # Loop until we've found enough numbers
    while(scalar(@fib_digit_sums) < $n){
        my $digit_sum = 0;

        # Add up all the digits in $i
        foreach(split('', $i)){
            $digit_sum += $_;
        }

        # See if we have a big enough Fibonacci
        # number yet...
        while($digit_sum >= $fib_b){
            # Calculate/store more until we do
            $fib_c = $fib_a + $fib_b;
            $fib_a = $fib_b;
            $fib_b = $fib_c;

            $fibs{$fib_b} = 1;
        }

        # See if the sum is a Fibonacci number
        if($fibs{$digit_sum}){
            # It is- store $i
            push(@fib_digit_sums, $i);
        }

        $i++;

    }

    return(@fib_digit_sums);

}



