#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @bit_strings = (
    "0101",
    "000111",
    "000011",
    "10011100",
    "00000"
);

print("\n");
foreach my $bit_string (@bit_strings){
    printf(
        "Input: \$binary = \"%s\"\nOutput: (%s)\n\n",
        $bit_string,
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                distinct_consecutive_groupings($bit_string)
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a binary string consisting only of '0' and '1' characters, find all
# distinct substrings therein that consist of at least two characters and have
# equal numbers of '0' and '1' characters, each arranged consecutively in
# groups at either end of the string (i.e.  "111000" but not "101010")
# Takes one argument:
# * The string to examine (e.g. "10011100")
# Returns:
# * A sorted list of distinct substrings that meet the criteria described above
#   (e.g.
#       ( "0011", "01", "10", "1100" )
#   ); this list may be empty (e.g. () ) if no qualifying substrings were found
################################################################################
sub distinct_consecutive_groupings{
    my $bits = shift();

    my $start;
    my $end;
    my $substring;
    my $length = length($bits) - 1;
    my %substrings;

    # Loop over the start and end positions of
    # every possible substring with an even
    # number of characters
    foreach $start (0 .. $length - 1){
        for($end = $start + 1; $end <= $length; $end += 2){
            # Extract the substring, and store it in the
            # substrings table if it consists only of a
            # consecutive group of one character followed
            # by a consecutive group of a different
            # character, and both the consecutive groups
            # have the same length
            $substring = substr($bits, $start, ($end + 1) - $start);
            $substrings{$substring} = 1
                if(
                    ($substring =~ m/^((\d)\2*)(((?!\2).)\4*)$/)
                    &&
                    (length($1) == length($3))
                );
        }
    }

    return(sort(keys(%substrings)));

}



