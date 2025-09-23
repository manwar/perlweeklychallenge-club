#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "abbaca",
    "azxxzy",
    "aaaaaaaa",
    "aabccba",
    "abcddcba"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = '%s'\nOutput: '%s'\n\n",
        $string,
        make_duplicate_free($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, repeatedly remove adjacent duplicate letters until no
# adjacent duplicates remain, even those produced by previous removals; if this
# results in the removal of all letters, an empty string will be returned
# Takes one argument:
# * The string to process (e.g. "azxxzy")
# Returns:
# * The string with all duplicates removed as described above (e.g. "ay")
################################################################################
sub make_duplicate_free{
    my $str = shift();

    # Substitute an empty string (as opposed to
    # a blank expression, to suppress 'uninitialized
    # value' warnings) for all instances of two
    # adjacent characters; keep doing so until no
    # substitutions are made
    while($str =~ s/(.)\1/""/ge){
        ;;
    }

    return($str);

}



