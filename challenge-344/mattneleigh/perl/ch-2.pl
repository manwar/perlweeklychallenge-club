#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ [ 2, 3 ], [ 1 ], [ 4 ] ],
        [ 1, 2, 3, 4 ]
    ],
    [
        [ [ 1, 3 ], [ 2, 4 ] ],
        [ 1, 2, 3, 4 ]
    ],
    [
        [ [ 9, 1 ], [ 5, 8 ], [ 2 ] ],
        [ 5, 8, 2, 9, 1 ]
    ],
    [
        [ [ 1 ], [ 3 ] ],
        [ 1, 2, 3 ]
    ],
    [
        [ [ 7, 4, 6 ] ],
        [ 7, 4, 6 ]
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \@source = (%s)\n\@target = (%s)\nOutput: %s\n\n",
        join(
            ", ",
            map(
                "[ " . join(", ", @{$_}) . " ]",
                @{$data_set->[0]}
            )
        ),
        join(", ", @{$data_set->[1]}),
        can_build_target($data_set) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a target list can be constructed using all members of a set
# of source lists, without modifying the order or composition of the elements
# within any source list
# Takes one argument:
# * A ref to an array containing the source lists and the targt list (e.g.
#       [
#           [ [ 2, 3 ], [ 1 ], [ 4 ] ],
#           [ 1, 2, 3, 4 ]
#       ]
# )
# Returns:
# * A value that evaluates as true if the target list can be constructed using
#   the provided source segments (as would be the case in the example above)
# * A value that evaluates as false if the target list can NOT be constructed
#   using the provided source segments
################################################################################
sub can_build_target{

    # Check the source lists for compatibility
    # with the target
    {
        my $sum = 0;

        # Add up the number of elements in the source
        # lists
        foreach my $segment (@{$ARG[0][0]}){
            $sum += scalar(@{$segment});
        }

        # Compare with the number of target elements
        return(0)
            unless(scalar(@{$ARG[0][1]}) == $sum);
    }

    # Convert the target to a string
    my $target = join("", @{$ARG[0][1]});

    return(
        # Permute the source segments
        permutations_iterative(
            sub{
                # Not using the data argument
                shift();

                # See if concatenating this permutation
                # matches the target, and return true or
                # false as appropriate
                return($target eq join("", @ARG));

            },
            # As noted above, no data arg to pass
            undef,
            # Convert the source segments to strings
            map(
                join("", @{$_}),
                @{$ARG[0][0]}
            )
        )
    );

}



################################################################################
# Iterate through all (maybe- see below) permutations of the ordering of the 
# items in a list, calling a supplied subroutine on each permutation; this
# subroutine may terminate iteration early by returning a value that evaluates
# as true
# Takes three arguments:
# * A ref to a callback subroutine, to be called on each permutation (see
#   below)
# * A scalar data argument that will be passed to the subroutine upon each
#   call; this is intended to contain or refer to any outside data structures
#   the callback subroutine needs, but may be undef if it will not be used
# * The list to permute
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
#   NOTE: This list is passed as an array slice from permutations_iterative()'s
#   own argument list (@_ or @ARG) so any changes made to these list values
#   will be reflected in subsequent permutations AND the caller's copy of the
#   original list (see 'man perlsub' for more information on argument aliasing)
# Return values expected from the callback subroutine:
# * 0 (or any non-true value) if permutation of the list is to be continued
# * 1 (or any true value) if permutation of the list is to be halted; this
#   will be returned to the caller of permutations_iterative()
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
#   permutations_iterative(
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
#       # As noted above, no data arg to pass
#       undef,
#       @list
#   );
#
#   print($permutations, " permutations processed\n");
#
# NOTE: Adapted from the verbal description (but not the source code) of the
# algorithm found at:
# https://www.pepcoding.com/resources/online-java-foundation/string,-string-builder-and-arraylist/print_all_permutations_of_a_string_iteratively/topic
################################################################################
sub permutations_iterative{
    # Make integer math obligatory but faster
    use integer;

    my $callback = shift();
    my $data_arg = shift();

    my $n = scalar(@ARG);
    my $n_fact = 1;
    my @indices;
    my $quotient;
    my $remainder;
    my $rval;

    # Calculate the factorial of $n
    foreach(2 .. $n){
        $n_fact *= $_;
    }

    # Loop from 0 to n! - 1
    foreach my $i (0 .. $n_fact - 1){
        # Set up a list of array indices in normal
        # order
        @indices = (0 .. $#ARG);
        $quotient = $i;

        # Call the supplied subroutine on the data
        # arg and a slice of the list of things to
        # permute, with indices calculated from the
        # current value of $i, thus determining the
        # current permutation
        $rval = &{$callback}(
            $data_arg,
            @ARG[
                map(
                    splice(@indices, $_, 1),
                    map(
                        {
                            $remainder = $quotient % $_;
                            $quotient = $quotient / $_;

                            $remainder;
                        }
                        reverse(1 .. $n)
                    )
                )
            ]
        );

        # Return the value returned by the callback
        # if we were told to stop (not-false value)
        return($rval)
            if($rval);
    }

    return(0);

}



