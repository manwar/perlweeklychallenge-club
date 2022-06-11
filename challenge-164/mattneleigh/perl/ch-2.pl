#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @happy_numbers = ();
my $m = 1;
my $n = 8;

while(scalar(@happy_numbers) < $n){
    push(@happy_numbers, $m)
        if(is_happy_number_b10($m));
    $m++;
}

print("\nThe first $n happy numbers in Base 10 are:\n\n");
printf("    %s\n", join(", ", @happy_numbers));
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a positive integer is a Happy Number in Base 10; see
# https://en.wikipedia.org/wiki/Happy_number for a description of the Happy
# Numbers
# Takes one argument:
# * The integer N to examine
# Returns on success:
# * 1 if N is a Happy Number
# * 0 if N is not a Happy Number
# Returns on error:
# * undef if N is less than 1
################################################################################
sub is_happy_number_b10{
    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my %seen = ();

    # Loop until one of the exit criteria triggers
    # a return from the function
    while(1){
        my $sum_squares = 0;

        # If $n is one, we've found a happy number;
        # return true
        return(1)
            if($n == 1);

        # Sum the squares of the digits in $n
        foreach(split("", $n)){
            $sum_squares += $_ * $_;
        }

        # If we've seen this value of $sum_squares
        # before, we didn't start with a happy number;
        # return false
        return(0)
            if($seen{$sum_squares});

        # Store the sum of the squares for later
        # examination in future iterations, and set
        # $n to this new value
        $seen{$sum_squares} = 1;
        $n = $sum_squares;
    }

}



