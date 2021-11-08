#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @input = (1, 7, 10, 15, 100, 200);

# Calculate enough Ugly Numbers to satisfy
# the largest argument we have
my @ugly_numbers = compute_N_ugly_numbers($input[max_value_index(@input)]);

foreach(@input){
    printf("%4d --> %5d\n", $_, $ugly_numbers[$_ - 1]);
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Compute the Nth Ugly Number- a positive integer whose only prime factors are
# 2, 3, or 5
# Takes one argument:
# * A positive integer (N) that indicates which Ugly Number out of the sequence
#   of same is to be calculated; if N is not an integer it will be truncated
# Returns on success:
# * The Nth Ugly Number
# Return on error:
# * undef if N wasn't a number greater than zero
################################################################################
sub compute_Nth_ugly_number{
    my $n = shift();

    my @ugly_numbers = compute_N_ugly_numbers($n);

    # Make sure we got a defined array
    # from compute_N_ugly_numbers()
    return(undef) unless(defined($ugly_numbers[0]));

    # Return the last number in the list
    return($ugly_numbers[$#ugly_numbers]);

}



################################################################################
# Compute the first N Ugly Numbers- positive integers whose only prime factors
# are 2, 3, or 5
# Takes one argument:
# * A positive integer (N) that indicates how many Ugly Numbers out of the
#   sequence of same are to be calculated; if N is not an integer it will be
#   truncated
# Returns on success:
# * A list of the first N Ugly Numbers; by convention the first element of this
#   list will be 1
# Return on error:
# * undef if N wasn't a number greater than zero
################################################################################
sub compute_N_ugly_numbers{
    my $n = shift();

    # Compute and return a set of composite
    # numbers using the particular factors
    # that produce Ugly Numbers...
    return(compute_N_composite_numbers($n, (2, 3, 5)));

}



################################################################################
# Compute the first N composite numbers (miltiplicative products in various
# combinations) of a specified set of factors
# Takes two arguments:
# * The number (N) of composite numbers to calculate, which must be at least 1;
#   if N is not an integer it will be truncated
# * A list of factors to be multiplied to produce composite numbers, which must
#   contain at least one number, and each number must be at least 1; any number
#   that is not an integer will be truncated
# Returns on success:
# * A list of the first N composite numbers; by convention the first element of
#   this list will be 1
# Return on error:
# * undef if no factors are specified or if N or any factor wasn't a number
#   greater than zero
################################################################################
sub compute_N_composite_numbers{
    my $n = int(shift());

    my @indices;
    my @factors;
    my @products;

    # Populate the list in case $n == 1
    my @composite_list = (1);

    # If $n wasn't an number and greater
    # than zero
    return(undef) unless($n > 0);

    # No further args were supplied
    return(undef) unless(scalar(@ARG));

    while(defined($ARG[0])){
        push(@factors, int(shift()));
        # A factor wasn't a number and
        # greater than zero
        return(undef) unless($factors[$#factors] > 0);
    }

    # Initialize indices
    for(0..$#factors){
        push(@indices, 0);
    }

    $n--;
    while($n--){
        for(0..$#factors){
            # Multiply our factors by particular numbers
            # previously calculated; @products will be
            # autovivified on the first pass
            $products[$_] = $composite_list[$indices[$_]] * $factors[$_];
        }

        # Store the minimum value we just calculated
        push(@composite_list, $products[min_value_index(@products)]);

        for(0..$#factors){
            # If any product we calculated equals the
            # minimum number we stored, increment the
            # corresponding index
            if($products[$_] == $composite_list[$#composite_list]){
                $indices[$_]++;
            }
        }
    }

    # Return the list
    return(@composite_list);

}



################################################################################
# Determine the index of the lowest numerical value in a list
# Takes as arguments:
# * A list of numerical values which may be of any nonzero length
# Returns on success:
# * The index of the minimum value in the list; if the minimum value occurs
#   multiple times, this will be the index of the first occurance
# Returns on error:
# * undef if the list is of zero length
################################################################################
sub min_value_index{

    my $i = 0;
    my $min_i = 0;

    return(undef) unless(scalar(@ARG));

    for($i=1; $i<=$#ARG; $i++){
        if($ARG[$i] < $ARG[$min_i]){
            $min_i = $i;
        }
    }

    return($min_i);

}



################################################################################
# Determine the index of the highest numerical value in a list
# Takes as arguments:
# * A list of numerical values which may be of any nonzero length
# Returns on success:
# * The index of the maximum value in the list; if the maximum value occurs
#   multiple times, this will be the index of the first occurance
# Returns on error:
# * undef if the list is of zero length
################################################################################
sub max_value_index{

    my $i = 0;
    my $max_i = 0;

    return(undef) unless(scalar(@ARG));

    for($i=1; $i<=$#ARG; $i++){
        if($ARG[$i] > $ARG[$max_i]){
            $max_i = $i;
        }
    }

    return($max_i);

}



