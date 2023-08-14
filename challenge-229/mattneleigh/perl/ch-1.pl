#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_lists = (
    [ "abc", "bce", "cae" ],
    [ "yxz", "cba", "mon" ]
);

print("\n");
foreach my $string_list (@string_lists){
    printf(
        "Input: \@str = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map("\"" . $_ . "\"", @{$string_list})
        ),
        delete_unordered_strings($string_list)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a ref to a list of strings, delete the strings whose characters are not
# sorted in lexicographical order, either ascending or descending
# Takes one argument:
# * A ref to the list of strings to examine (e.g. [ "abc", "bce", "cae" ] )
# Returns
# * The number of deletions (e.g. 1 )
# NOTE: The list will be modified if any deletions are performed
################################################################################
sub delete_unordered_strings{
    my $strings = shift();

    my $deletions = 0;
    my $i = 0;

    while($i <= $#$strings){
        my $sorted = join("", sort(split(//, $strings->[$i])));

        # Compare original and lexicographically
        # sorted- in both directions- sequences of
        # characters in the string
        if(
            ($strings->[$i] eq $sorted)
            ||
            ($strings->[$i] eq reverse($sorted))
        ){
            # String matches at least one arrangement
            # of characters; move on to the next
            # string
            $i++;
        } else{
            # No match; delete the string and
            # increment the count
            splice(@{$strings}, $i, 1);
            $deletions++;
        }
    }

    return($deletions);

}



