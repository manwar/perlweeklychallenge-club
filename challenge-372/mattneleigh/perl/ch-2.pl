#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "aaaaa",
    "abcdeba",
    "abbc",
    "abcaacbc",
    "laptop",

    # Additional test case(s)
    "abcdefgh"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        longest_bracketed_substring($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, find the longest substring that sits between two identical
# characters but does NOT include the instances of those characters that
# bracket the substring in question; if the only two identical characters are
# adjacent, the length of the substring between them is zero (0) so that value
# will be returned, while -1 will be returned if no such substring exists
# Takes one argument:
# * The string to examine (e.g. "abcabcdbe")
# Returns:
# * The length of the longest substring between two identical characters, or -1
#   if no such substring exists (e.g. 5 - the longest qualifying substring is
#   "cabcd", of length 5, bracketed by two instances of "b"; the "b" within the
#   substring doesn't prevent it from being counted as the longest)
################################################################################
sub longest_bracketed_substring{
    my $string = shift();

    my $global_length = length($string);
    my $local_length;
    my $max_length = -1;

    # Loop over possible substring locations
    for my $base (0 .. $global_length - 1){
        # Loop over possible offset locations
        for my $offset (1 .. $global_length - $base - 1){
            if(substr($string, $base, 1) eq substr($string, -$offset, 1)){
                # The offset character matches the base;
                # compute the length of the string between
                # them and store it if it's the new maximum
                $local_length = $global_length - $offset - $base - 1;
                $max_length = $local_length
                    if($local_length > $max_length);

                # Skip to the next base letter as any further
                # substrings we find would be shorter
                last;
            }
        }

        # Stop searching if there cannot be any
        # substrings longer than the current maximum
        # in the remaining portion of the string
        last
            if(($global_length - $base - 2) <= $max_length);
    }

    return($max_length);

}



