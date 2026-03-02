#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "abca",
    "xyz",
    "code",
    "hello",
    "a"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        positional_repeat($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, produce a copy thereof with each character repeated a number
# of times dictated by its position within the original string, starting with
# 1 (i.e. in "apple", 'a' is in position 1, 'p' in position 2, 'p' in position
# 3, etc.)
# Takes one argument:
# * The string to examine (e.g. "apple")
# Returns:
# * The string with characters repeated as described (e.g. "appppplllleeeee")
################################################################################
sub positional_repeat{
    my $input = shift();

    my $output = "";

    for my $i (0 .. length($input) - 1){
        $output .= substr($input, $i, 1) x ($i + 1);
    }

    return($output);

}



