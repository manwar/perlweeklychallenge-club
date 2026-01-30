#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [ "123", "45", "6" ],
    [ "abc", "de", "fghi" ],
    [ "0012", "99", "a1b2c" ],
    [ "x", "10", "xyz", "007" ],
    [ "hello123", "2026", "perl" ]
);

print("\n");
foreach my $strings (@string_sets){
    printf(
        "Input: \@strings = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$strings}
            ),
        ),
        max_numerical_representation(@{$strings})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of strings consisting of only alphanumeric characters,
# determine the the value of the string with the maximum numerical
# representation, where this value is defined as either the number made of the
# digits within the string if it consists solely of digits, or the length of
# the string otherwise
# Takes one argument:
# * An array of strings to examine (e.g. ("abc", "de", "3", "fghi") )
# Returns:
# * The maximum numerical representation among the strings, as defined above
#   (e.g. 4)
################################################################################
sub max_numerical_representation{
    use List::Util qw(max);

    return(
        max(
            # Get the 'value' of each string
            map(
                $_ =~ m/\D/ ?
                    # The string contains non-digits- return
                    # its length
                    length($_)
                    :
                    # The string is all digits- return it
                    $_,
                @ARG
            )
        )
    );

}



