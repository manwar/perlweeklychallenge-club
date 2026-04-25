#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_pairs = (
    [ "abc",   "acb"   ],
    [ "abcd",  "cdba"  ],
    [ "hello", "hiiii" ],
    [ "ateer", "eater" ],
    [ "abcd",  "bdac"  ]
);

print("\n");
foreach my $word_pair (@word_pairs){
    printf(
        "Input: \$str1 = \"%s\", \$str2 = \"%s\"\nOutput: %s \n\n",
        $word_pair->[0],
        $word_pair->[1],
        is_scramble(@{$word_pair}) ?
            "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a reference string, and a string that might be a scrambled version of
# the reference string (see scramble_unique() below for approved scrambling
# methodology) determine whether the alleged scramble is indeed a scramble of
# the reference string
# Takes two arguments:
# * The rference string (e.g. "abcd")
# * A string that may or may not be a scramble of the reference string
#   (e.g. "bdac")
# Returns
# * 0 if the scrambled string is not a scramble of the reference string (as
#   would be the case for example above)
# * 1 if the scrambled string is a scramble of the reference string
################################################################################
sub is_scramble{
    my $string = shift();
    my $scramble = shift();

    # Generate a set of scrambles from the string
    my $scrambles = scramble_unique($string);

    # Based on whether the alleged scramble is in
    # the set of generated scrambles, return a
    # corresponding value
    return(
        $scrambles->{$scramble} ? 1 : 0
    );

}



################################################################################
# Scramble a string according to a particular set of operations:
# * If the string consists of only one character, return the string.
# * Divide the string into two non-empty parts.
# * Optionally, exchange the order of those parts.
# * Optionally, scramble each of those parts.
# * Concatenate the scrambled parts to return a single string.
# Takes one argument:
# * The string to scramble (e.g. "abc")
# Returns:
# * A ref to a hash containing unique scrambles of the supplied string as keys,
#   and values that evaluate as true as values (e.g.
#       {
#           acb => 1,
#           abc => 1,
#           bac => 1,
#           cab => 1,
#           cba => 1,
#           bca => 1
#       }
#   )
#   Note that the supplied string will be included among the scrambles, and
#   that the order in which keys appear if listed via keys() is determined by
#   Perl's hash implementation
################################################################################
sub scramble_unique{
    my $string = shift();

    my $length = length($string);

    # Just one character- return a hash
    # containing only it
    return({ $string => 1 })
        if($length == 1);

    my %scrambles;

    # Loop over positions that divide the string
    # into left and right segments of non-zero
    # length
    foreach my $pos (1 .. $length - 1){
        # Generate scrambles of each portion
        my $left_scrambles = scramble_unique(substr($string, 0, $pos));
        my $right_scrambles = scramble_unique(substr($string, $pos - $length));

        # Loop over scrambles of the left portion
        foreach my $left_scramble (keys(%{$left_scrambles})){
            # Loop over scrambles of the right portion
            foreach my $right_scramble (keys(%{$right_scrambles})){
                # Concatenate the scrambles in both orders
                # and store unique combinations
                $scrambles{$left_scramble . $right_scramble} = 1;
                $scrambles{$right_scramble . $left_scramble} = 1;
            }
        }
    }

    return(\%scrambles);
    
}



