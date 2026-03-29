#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [ [ "a", "ap", "app", "apple", "banana" ], "apple" ],
    [ [ "cat", "dog", "fish" ], "bird" ],
    [ [ "hello", "he", "hell", "heaven", "he" ], "hello" ],
    [ [ "", "code", "coding", "cod" ], "coding" ],
    [ [ "p", "pr", "pro", "prog", "progr", "progra", "program" ], "program" ]
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \@array = (%s), \n       \$str = \"%s\"\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$string_set->[0]}
            )
        ),
        $string_set->[1],
        count_prefixes(@{$string_set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of words, determine how many are a prefix (that is, appear at
# the beginning of) a supplied string
# Takes two arguments:
# * A ref to an array of words (e.g. [ "", "code", "coding", "cod" ] )
# * A string to examine for prefixes (e.g. "coding")
# Returns:
# * The number of words that are prefixes of the given string (e.g. 3)
################################################################################
sub count_prefixes{
    my @words = @{shift()};
    my $string = shift();

    my $prefixes = 0;

    # Loop over each word
    foreach my $word (@words){
        # Count the words that appear at the
        # beginning of the string
        $prefixes++
            if($string =~ m/^$word/);
    }

    return($prefixes);

}



