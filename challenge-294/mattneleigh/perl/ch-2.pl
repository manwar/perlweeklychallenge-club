#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 1, 2, 3 ],
    [ 2, 1, 3 ],
    [ 3, 1, 2 ],

    # Additional test cases
    [ 6, 5, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", next_permutation(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, produce the next permutation, lexicographically
# speaking, of the list
# Takes one argument:
# * The list of integers to examine (e.g. ( 1, 2, 3 ) )
# Returns:
# * The next permutation, lexicographically speaking, of the original list
#   (e.g. ( 1, 3, 2 ) )
# * The empty list (e.g. () ) if the supplied list was already the last
#   permutation, lexicographically speaking
################################################################################
sub next_permutation{
    my @integer_list = @ARG;

    my $iteration = 0;
    my @permutation;

    # Call the lexicographical permutation generator
    # from ch-2 of PWC 260, but with some different
    # args
    permutations_iterative_lexicographical(
        # This sub will be called on the original list
        # first, so we'll bail after the SECOND call to
        # it
        sub{
            # Not using the data argument
            shift();
 
            # Increment count (variable scoped to the
            # calling code)
            $iteration++;
 
            if($iteration == 2){
                # This is the second call- store the perm
                # (variable scoped to the calling code) and
                # signal an end to processing
                @permutation = @ARG;
                return(1);
            }

            # Indicate that processing is to continue
            return(0);
        },
 
        # No data arg to pass
        undef,

        # Since we just want the next permutation, we do
        # NOT sort the list
        @integer_list
    );

    return(@permutation);

}



################################################################################
# Iterate through all (maybe- see below) unique permutations of the ordering
# of the items in a list, in lexicographical order, calling a supplied
# subroutine on each permutation; this subroutine may terminate iteration early
# by returning a value that evaluates as true
# Takes three arguments:
# * A ref to a callback subroutine (see below) to be called on each
#   permutation; this subroutine is responsible for storing or processing the
#   permutations generated, as needed
# * A scalar data argument that will be passed to the subroutine upon each
#   call; this is intended to contain or refer to any outside data structures
#   the callback subroutine needs, but may be undef if it will not be used
# * The list to permute, which MUST be sorted in ascending lexicographical
#   order if a full set of permutations is to be generated; ordinarily if
#   duplicate items were present in the list, a number of indistinguishable
#   permutations would be generated, but this function will only produce
#   unique permutations.  All members of the list should be of the same letter
#   case if case is not considered significant by the calling code, as it IS
#   significant for comparison purposes and will affect the number and order of
#   permutations generated.
# Returns:
# * 0 if all permutations of the list were acted upon by the callback
#   subroutine
# * The value returned by the callback subroutine if it returned one that
#   evaluates as true, thus halting processing of permutations
#
# Arguments passed to the callback subroutine:
# * The scalar data argument described above; whether used or not, it is
#   recommended that this argument be shift()ed out of @_ (or @ARG) so the
#   array contains only the permutation to be processed
# * A list containing the current permutation of the supplied list
#   NOTE: This list is passed as an array used internally by
#   permutations_iterative_lexicographical(); any changes made to these list
#   values will be reflected in subsequent permutations and should be avoided
#   (see 'man perlsub' for more information on argument aliasing)
# Return values expected from the callback subroutine:
# * 0 (or any non-true value) if permutation of the list is to be continued
# * 1 (or any true value) if permutation of the list is to be halted; this
#   will be returned to the caller of permutations_iterative_lexicographical()
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
#   permutations_iterative_lexicographical(
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
#       # This must be sorted if it isn't
#       # already
#       sort(@list)
#   );
#
#   print($permutations, " permutations processed\n");
#
# NOTE: Adapted from the verbal description of Narayana Pandita's method found
# at: https://en.wikipedia.org/wiki/Permutation#Permutations_in_computing
################################################################################
sub permutations_iterative_lexicographical{
    my $callback = shift();
    my $data_arg = shift();
    my @items = @ARG;

    my $rval;
    my $largest_k;
    my $largest_l;

    while(1){
        $largest_k = undef;

        # Call the supplied subroutine on the data
        # arg and the list of things representing
        # the current permutation
        $rval = &{$callback}(
            $data_arg,
            @items
        );

        # Return the value returned by the callback
        # if we were told to stop (not-false value)
        return($rval)
            if($rval);

        # Find the largest $k for which
        # $items[$k] < $items[$k + 1],
        # lexicographically speaking
        for my $k (0 .. $#items - 1){
            $largest_k = $k
                if(($items[$k] cmp $items[$k + 1]) == -1);
        }

        # If we didn't find a largest $k that met
        # the criteria above, we're done
        last
            unless(defined($largest_k));

        # Find the largest $l larger than
        # $largest_k for which
        # $items[$largest_k] < $items[$l],
        # lexicographically speaking
        for my $l ($largest_k + 1 .. $#items){
            $largest_l = $l
                if(($items[$largest_k] cmp $items[$l]) == -1);
        }

        # Swap the values at $largest_k and
        # $largest_l
        @items[$largest_k, $largest_l] =
            @items[$largest_l, $largest_k];

        # Reverse the contents of the array after
        # $largest_k
        @items[$largest_k + 1 .. $#items] =
            @items[reverse($largest_k + 1 .. $#items)];
        
    }

    return(0);

}



