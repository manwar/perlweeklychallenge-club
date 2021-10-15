#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $quantity = 5;

print("The first ", $quantity, " pandigital numbers in Base 10 are:\n");
foreach(find_pandigital_numbers($quantity)){
    print("  $_\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the first N pandigital numbers in Base 10
# Takes one argument:
# * The number N of pandigital numbers to find
# Returns:
# * A list of N pandigital numbers in Base 10, in ascending order
################################################################################
sub find_pandigital_numbers{
    my $n = shift();

    my $digit_count;
    my @digits;
    my @permutations = ();
    my @pandigitals = ();

    # Cheat (a little) by setting up the
    # smallest pandigital number in Base 10 to
    # start with
    @digits = (1, 0, 2, 3, 4, 5, 6, 7, 8, 9);

    # The inverse factorial of the quantity of
    # numbers we're expected to find will tell
    # us how many digits need to be permuted;
    # calculate this and make sure the value
    # is sane
    $digit_count = inverse_factorial($n);
    if($digit_count > scalar(@digits)){
        $digit_count = scalar(@digits);
    }

    # Gather a list of permutations involving
    # only the requisite number of digits at the
    # end of the list- it saves some memory to
    # do it this way
    permute_list_sequence(
        [ @digits[$#digits - $digit_count + 1 .. $#digits] ],
        0,
        $digit_count,
        \@permutations
    );

    if($digit_count == scalar(@digits)){
        # All the digits were used for
        # permutations; build strings out of the
        # permuted digits.
        # Assignment in conditional is deliberate
        while(my $permutation = shift(@permutations)){
            # Most definitions of a pandigital number
            # don't permit leading zeros, so skip any
            # permutations that have ended up with
            # one; this should only happen if all
            # available digits were permuted
            next if($permutation->[0] == 0);
            $permutation = join(
                "",
                @{$permutation}
            );
            push(@pandigitals, $permutation);
        }
    } else{
        # There are unpermuted digits; build
        # strings out of the unpermuted and permuted
        # digits.
        # Assignment in conditional is deliberate
        while(my $permutation = shift(@permutations)){
            $permutation = join(
                "",
                @digits[0 .. $#digits - $digit_count],
                @{$permutation}
            );
            push(@pandigitals, $permutation);
        }
    }

    # The numbers likely won't be in ascending
    # order, however; sort them and return the
    # desired quantity
    $n--;
    return(
        (sort(@pandigitals))[
            0 .. ($n < $#pandigitals ? $n : $#pandigitals)
        ]
    );

}



################################################################################
# Generate a sequence of permutations based on the contents of a supplied
# array.  Permutations will take place within the specified range of cells,
# which must be within the array or undefined behavior may result.  The
# permutations may not be generated in any particularly meaningful order.
# Takes four arguments:
# * A ref to an array of cells to permute.  NOTE: this array will be modified
#   as the permutations are generated; see the output array below for a copy of
#   the array in its original order
# * The index of the first cell (base) of the active permutation region
# * The number of cells, including the base, that will be part of the active
#   permutation region
# * A ref to an array in which the permutations are to be stored as output;
#   this will be populated with permuted copies of the entire original input
#   array, including cells outside the active permutation region, if any.  The
#   first array in this list will contain the cells in their unpermuted order.
# Returns:
# * undef at all times, which conveys no meaningful information
# Adapted from Heap's Algorithm as described here
# https://www.geeksforgeeks.org/heaps-algorithm-for-generating-permutations/
################################################################################
sub permute_list_sequence{
    my $list = shift();
    my $base = shift();
    my $region_size = shift();
    my $permutations = shift();

    # Active region is just one cell-
    # store a copy of the current list
    if($region_size == 1){
        push(@{$permutations}, [ @{$list} ]);
        return();
    }

    for(0 .. $region_size - 1){
        # Recurse deeper with a smaller active
        # region
        permute_list_sequence(
            $list,
            $base,
            $region_size - 1,
            $permutations
        );

        if($region_size % 2){
            # Odd range size- swap first and last
            # elements in the active region
            @{$list}[$base, $base + $region_size - 1]
                = @{$list}[$base + $region_size - 1, $base];
        } else{
            # Even range size- swap the $_th and
            # last elements in the active region
            @{$list}[$base + $_, $base + $region_size - 1]
                = @{$list}[$base + $region_size - 1, $base + $_];
        }
    }

    return();

}



################################################################################
# Calculate the inverse factorial of an integer (i.e. given y, solve x! = y for
# x).  If the integer is not actually a factorial, the number calculated is the
# inverse of the next largest factorial (e.g. an input of 10 yields 4; 3! = 6
# while 4! = 24)
# Takes one argument:
# * A factorial whose inverse is to be calculated
# Returns:
# * The inverse of the factorial (or next largest factorial if the input is not
#   a factorial)
################################################################################
sub inverse_factorial{
    my $y = int(shift());

    my $x = 1;

    while($y > 1){
        $x++;
        $y /= $x; 
    }

    return($x);

}



