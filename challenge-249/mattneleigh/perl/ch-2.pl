#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "IDID",
    "III",
    "DDI",

    # If you have a lot of time on your
    # hands...
    # "DDIDIDDIID"
);

print("\n");
foreach my $string (@strings){
    my $matching_perms = find_matching_permutations($string);

    # Sort the permutation list for output
    @{$matching_perms->{matching_perms}} = sort(
        {
            my $i = 0;

            # Find the first index with unequal
            # values between permutations
            foreach(0 .. $#$a){
                unless($a->[$_] == $b->[$_]){
                    $i = $_;
                    last;
                }
            }

            # Sort on the first index with unequal
            # values, or 0 if no unequal values
            # were found
            $a->[$i] <=> $b->[$i];
        }
        @{$matching_perms->{matching_perms}}
    );

    printf(
        "Input: \$str = \"%s\"\nOutput:\n%s\n"
        .
        "With %d out of %d permutations matching\n\n",
        $string,
        join(
            "\n",
            map(
                sprintf("    ( %s )", join(", ", @{$_})),
                @{$matching_perms->{matching_perms}}
            )
        ),
        scalar(@{$matching_perms->{matching_perms}}),
        $matching_perms->{possible_perms}
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string $S consisting solely of 'I' and 'D' characters, find the
# permutations of the integers (0 .. length($S)) such that:
#     $S[$i] == 'I' => $permutation[$i] < $permutation[$i + 1]
#     $S[$i] == 'D' => $permutation[$i] > $permutation[$i + 1]
# Takes one argument:
# * The string to examine (e.g. "DDI")
# Returns:
# * A ref to a hash containing the number of possible permutations and the
#   ones that actually match the criteria specified above (e.g.
#       {
#           possible_perms => 24,
#           matching_perms => [
#               [ 2, 1, 0, 3 ],
#               [ 3, 1, 0, 2 ],
#               [ 3, 2, 0, 1 ]
#           ]
#       }
#   )
################################################################################
sub find_matching_permutations{

    # Split the input string into component
    # characters
    my @chars = split('', $ARG[0]);

    # Set up the output data structure
    my $perm_count = 0;
    my @matching_perms = ();

    my $i;

    permutations_iterative(
        sub{
            use integer;

            # Get rid of the undef data arg; we don't
            # have a use for it here
            shift();

            # Increment the permutation counter
            $perm_count++;

            foreach $i (0 .. $#chars){
                # See if this permutation matches the
                # desired criteria for this character
                # index; bail to the next permunation
                # if it doesn't
                return(0)
                    unless(
                        $chars[$i] eq 'I' ?
                            # Current character is I...
                            ($ARG[$i] < $ARG[$i + 1])
                            :
                            # Current character is D...
                            ($ARG[$i] > $ARG[$i + 1])
                    );
            }

            # This permutation matched desired
            # criteria for all character indices;
            # store it and return
            push(@matching_perms, [ @ARG ]);
            return(0);
        },
        undef,
        0 .. length($ARG[0])
    );

    return(
        {
            possible_perms => $perm_count,
            matching_perms => \@matching_perms
        }
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



