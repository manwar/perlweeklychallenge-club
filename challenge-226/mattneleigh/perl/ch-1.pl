#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @anagrams = (
    [
        "lacelengh",
        [ 3, 2, 0, 5, 4, 8, 6, 7, 1 ]
    ],
    [
        "rulepark",
        [ 4, 7, 3, 1, 0, 5, 2, 6 ]
    ]
);

print("\n");
foreach my $anagram (@anagrams){
    printf(
        "Input: \$string = '%s', \@indices = (%s)\nOutput: '%s'\n\n",
        $anagram->[0],
        join(", ", @{$anagram->[1]}),
        create_anagram_from_indices($anagram->[0], @{$anagram->[1]})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Rearrange a string (create an anagram) in accordance with a list of new
# positions each character is to occupy
# Takes two arguments:
# * The string to rearrange (e.g. "listen")
# * A list of new positions corresponding to each charater of the string (e.g.
#   ( 2, 1, 0, 5, 3, 4 ) )
# Returns:
# * The rearranged string (e.g. "silent")
################################################################################
sub create_anagram_from_indices{
    my $input = shift();

    # Generate a string of sufficient length
    my $output = " " x length($input);

    # Loop over the given positions
    foreach my $position (@ARG){
        # Remove the first character from the input
        # string and place it in the specified position 
        # in the output string
        substr($output, $position, 1, substr($input, 0, 1, ""));
    }

    return($output);

}



