#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "p|*e*rl|w**e|*ekly|",
    "perl",
    "th|ewe|e**|k|l***ych|alleng|e"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOuput: %d\n\n",
        $string,
        count_asterix_exclusive_of_pipes($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string with sections delimited by pairs of vertical bar/pipe
# characters ('|') count the number of asterisk characters ('*') that are NOT
# between a pair of vertical bars/pipes
# Takes one argument:
# * A string that contains a number of sections denoted by pairs of vertical
#   bar/pipe characters, and asterisk characters (e.g. "p|*e*rl|w**e|*ekly|" )
# Returns:
# * The count of asterisk characters that are not between pairs of vertical
#   bar/pipe characters (e.g. 2 )
################################################################################
sub count_asterix_exclusive_of_pipes{

    # Divide the string into 'words' separated by
    # the '|' character
    my @words = split(/\|/, shift());

    # Start this at -2 because it gets added to
    # at the start of each loop, later
    my $i = -2;

    my $limit = $#words;
    my $asterix_ct = 0;

    # Loop over each word until we've passed the
    # end of the list
    while(($i += 2) <= $limit){
        # Loop over each character within the word
        foreach my $chr (split(//, $words[$i])){
            # Count each asterix
            $asterix_ct++
                if($chr eq "*");
        }
    }

    return($asterix_ct);

}



