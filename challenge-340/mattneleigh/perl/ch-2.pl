#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "The cat has 3 kittens 7 toys 10 beds",
    "Alice bought 5 apples 2 oranges 9 bananas",
    "I ran 1 mile 2 days 3 weeks 4 months",
    "Bob has 10 cars 10 bikes",
    "Zero is 0 one is 1 two is 2",

    # Additional test cases
    "There are no numbers here"
);

print("\n");
foreach my $string (@strings){
    my $rval = all_numbers_ascending($string);

    printf(
        "Input: \$str = '%s'\nOutput: %s\n\n",
        $string,
        $rval ?
            "true"
            :
            defined($rval) ?
                "false"
                :
                "no numbers present"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, determine whether positive integers therein appear in
# ascending order from left to right
# Takes one argument:
# * The string to examine (e.g. "The cat has 3 kittens 7 toys 10 beds")
# Returns:
# * 0 if all the numbers in the string do NOT appear in ascending order
# * 1 if all the numbers in the string appear in ascending order (as it would
#   be in the case of the example above)
# * undef if there are no numbers in the string
################################################################################
sub all_numbers_ascending{

    my $previous = undef;

    # Loop over only the numbers in the string
    foreach my $number (grep(/^[0-9]+$/, split(" ", shift()))){
        if(defined($previous)){
            # There is a previously-defined number; bail
            # if the current number is not greater than
            # the previous one
            return(0)
                unless($number > $previous);
        }

        # Store this number to compare with the next
        # one
        $previous = $number
    }

    # Make sure we saw at least one number
    return(undef)
        unless(defined($previous));

    # Got here- every number was more than the
    # one that preceded it
    return(1);

}



