#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints = (
    2, 1, 10
);

print("\n");
foreach my $int (@ints){
    printf(
        "Input: \$n = %d\nOutput: %d\n\n",
        $int,
        count_beautiful_arrangements($int)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an integer N, determine how many Beautiful Permutations can be found
# within a list of numbers 1 to N, where a Beautiful Permutation is defined as
# one in which every element of the permuted list satisfies at least one of the
# following conditions:
#
#   1) $perm[$i] is divisible by ($i + 1) 
#   or
#   2) ($i + 1) is divisible by $perm[$i]
#
# where $i is zero-indexed as is traditional for lists/arrays
# Takes one argument:
# * The integer to examine (e.g. 10)
# Returns:
# * The number of Beautiful Permutations found (e.g. 700)
################################################################################
sub count_beautiful_arrangements{
    my $n = shift();

    my $beautiful_ct = 0;

    # Call the permutation generator
    permute_list_sequence_recursive(
        # See documentation for
        # permute_list_sequence_recursive() for a
        # description of the callback subroutine's
        # expected calling convention
        #### Begin callback subroutine ####
        sub{
            # Not using the data argument 
            shift();

            # Examine each member of this permutation
            foreach my $index (0 .. $#ARG){
                # Skip to the next permutation unless either
                # of these conditions are met:
                # 1) $ARG[$index] is divisible by $index + 1
                # 2) $index + 1 is divisible by $ARG[$index]
                # with 1 added to each index for math purposes
                # to simulate 1-indexing
                return(0)
                    unless(
                        !($ARG[$index] % ($index + 1))
                        ||
                        !(($index + 1) % $ARG[$index])
                    );
            }

            # If we got here, this is a Beautiful
            # Permutation; increment the count and move
            # on to the next permutation ($beautiful_ct
            # being scoped to the calling code)
            $beautiful_ct++;

            return(0);

        },
        #### End callback subroutine ####

        # No data arg to pass
        undef,

        # Generate the list of numbers to permute, and
        # define the region to act on (the entire
        # list)
        [ 1 .. $n ],
        0,
        $n
    );

    return($beautiful_ct);

}



################################################################################
# Generate a sequence of permutations based on the contents of a supplied
# array.  Permutations will take place within the specified range of cells,
# which must be within the array or undefined behavior may result.  The
# order in which particular permutations are generated may not be meaningful.
# Takes five arguments:
# * A ref to a callback subroutine (see below) to be called on each
#   permutation; this subroutine is responsible for storing or processing the
#   permutations generated, as needed
# * A scalar data argument that will be passed to the subroutine upon each
#   call; this is intended to contain or refer to any outside data structures
#   the callback subroutine needs, but may be undef if it will not be used
# * A ref to an array of cells to permute.  NOTE: this array will be modified
#   as the permutations are generated; provide a ref to a copy of the list if
#   the original order must be preserved
# * The index of the first cell (base) of the active permutation region
# * The number of cells, including the base, that will be part of the active
#   permutation region
# Returns:
# * 0 if all permutations of the list were acted upon by the callback
#   subroutine
# * The value returned by the callback subroutine if it evaluated as true, thus
#   halting processing of permutations
#
# Arguments passed to the callback subroutine:
# * The scalar data argument described above; whether used or not, it is
#   recommended that this argument be shift()ed out of @_ (or @ARG) so the
#   array contains only the permutation to be processed
# * A list containing the current permutation of the supplied list; the entire
#   list will be passed regardless of the size of the active permutation region
#   NOTE: This list is passed as an array used internally by
#   permute_list_sequence_recursive(); any changes made to these list values
#   will be reflected in subsequent permutations and should be avoided (see
#   'man perlsub' for more information on argument aliasing)
# Return values expected from the callback subroutine:
# * 0 (or any non-true value) if permutation of the list is to be continued
# * 1 (or any true value) if permutation of the list is to be halted; this
#   will be returned to the caller of permute_list_sequence_recursive()
#
# Example:
#
#   use English;
#
#   my $permutations = 0;
#   my @list = qw(a b c d e);
#
#   # Print out and count all permutations of
#   # @list; return value discarded in this
#   # case since it will always be 0
#   permute_list_sequence_recursive(
#       sub{
#           # Not using the data argument
#           shift();
#
#           # Increment permutation count (variable
#           # scoped to the calling code) and print
#           # out the contents of the permutation
#           $permutations++;
#           print(join(", ", @ARG), "\n");
#
#           # Indicate that processing is to continue
#           return(0);
#       },
#
#       # As noted above, no data arg to pass
#       undef,
#
#       # Generate a copy of the list as the
#       # one provided will be modified; a simple
#       # reference would suffice if the order of
#       # the original list need not be preserved
#       [ @list ]
#
#       # Initial active region is the whole
#       # list
#       0,
#       scalar(@list)
#   );
#
#   print($permutations, " permutations processed\n");
#
# Adapted from Heap's Algorithm as described here
# https://www.geeksforgeeks.org/heaps-algorithm-for-generating-permutations/
################################################################################
sub permute_list_sequence_recursive{
    my (
        $callback, $data_arg, $list, $base, $region_size
    ) = @ARG;

    my $rval;

    # Active region is just one cell- call the
    # subroutine on the current list and pass
    # along its return value
    if($region_size == 1){
        return(
            &{$callback}(
                $data_arg,
                @{$list}
            )
        );
    }

    for(0 .. $region_size - 1){
        # Recurse deeper with a smaller active
        # region, and capture the value returned
        $rval = permute_list_sequence_recursive(
            $callback,
            $data_arg,
            $list,
            $base,
            $region_size - 1,
        );

        # Break off the search and pass on the value
        # returned by the deeper call if an early
        # end to permuting has been requested
        return($rval)
            if($rval);

        if($region_size % 2){
            # Odd range size- swap first and last
            # elements in the active region
            @{$list}[$base, $base + $region_size - 1]
                = @{$list}[$base + $region_size - 1, $base];
        } else{
            # Even range size- swap the $_th and last
            # elements in the active region
            @{$list}[$base + $_, $base + $region_size - 1]
                = @{$list}[$base + $region_size - 1, $base + $_];
        }
    }

    # No early end to permutation at this level
    # has been requested; return zero
    return(0);

}



