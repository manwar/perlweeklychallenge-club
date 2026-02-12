#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "The quick brown fox",
    "Hello    World!   How   are you?",
    "Hello",
    "Hello, World! How are you?",
    "I have 2 apples and 3 bananas!"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        case_insensitive_sentence_rearrangement($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a sentence, rearrange all the words therein in ascending
# lexicographical order, case-insensitively, while not changing any of the
# words themselves
# Takes one argument:
# * The sentence to process (e.g. "Hello, World! How are you?")
# Returns:
# * The sentence with words rearranged as described above (e.g.
#   "are Hello, How World! you?")
################################################################################
sub case_insensitive_sentence_rearrangement{
    use v5.16;

    # 1) Split the sentence into words
    # 2) Sort the words with a case-folding
    #    comparison (2a)
    # 3) Rejoin words with spaces
    #      3         2      2a                   1
    return(join(" ", sort({ fc($a) cmp fc($b); } split(" ", shift()))));

}



