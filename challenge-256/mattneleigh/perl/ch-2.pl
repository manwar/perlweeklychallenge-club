#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_lists = (
    [ "abcd", "1234" ],
    [ "abc", "12345" ],
    [ "abcde", "123" ]
);

print("\n");
foreach my $string_list (@string_lists){
    printf(
        "Input: \$str1 = \"%s\", \$str2 = \"%s\"\nOutput: \"%s\"\n\n",
        $string_list->[0],
        $string_list->[1],
        merge_from_alternate_strings(@{$string_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two strings, merge them by combining one character from each, in
# alternating order, starting with the first string; if one string is longer
# than the other, remaining characters from it will be appended at the end
# Takes two arguments:
# * The first string to concatenate (e.g. "abc")
# * The second string to concatenate (e.g. "12345")
# Returns:
# * A string merged as defined above (e.g. "a1b2c345")
################################################################################
sub merge_from_alternate_strings{

    my @str1 = split("", $ARG[0]);
    my @str2 = split("", $ARG[1]);
    my $merged = "";

    # Concatenate characters from @str1 and @str2
    # while neither is empty
    while(@str1 && @str2){
        $merged .= shift(@str1) . shift(@str2);
    }

    # At least one array is now empty; if anything
    # remains in either, concatenate what's left
    if(@str1){
        $merged .= join("", @str1);
    } elsif(@str2){
        $merged .= join("", @str2);
    }

    return($merged);

}



