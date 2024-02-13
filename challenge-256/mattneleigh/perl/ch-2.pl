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

    my $length1 = length($ARG[0]);
    my $length2 = length($ARG[1]);
    my $common_length = $length1 < $length2 ?
        $length1
        :
        $length2;
    my $merged = "";

    # Over the length the strings have in common,
    # concatenate a pair of characters from each
    for my $pos (0 .. $common_length - 1){
        $merged .=
            substr($ARG[0], $pos, 1)
            .
            substr($ARG[1], $pos, 1);
    }

    # At least one string has been used up; if one
    # is longer than their common length,
    # concatenate the remaining characters from it
    if($length1 > $common_length){
        $merged .= substr($ARG[0], $common_length);
    } elsif($length2 > $common_length){
        $merged .= substr($ARG[1], $common_length);
    }

    return($merged);

}



