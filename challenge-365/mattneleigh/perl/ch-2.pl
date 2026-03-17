#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "cat and dog",
    "a-b c! d,e",
    "hello-world! this is fun",
    "ab- cd-ef gh- ij!",
    "wow! a-b-c nice."
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        count_valid_tokens($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a sentence made up of tokens separated by spaces, determine how many
# are valid according to the following criteria:
# * Valid tokens must not contain any digits
# * Valid tokens may contain at most one hyphen, and if present, it must be
#   situated between lower-case letters
# * Valid tokens maiy contain at most one punctuation mark, which may be a
#   comma (,), period (.), or exclamation mark (!), and if present, it must be
#   at the end of the token
# Takes one argument:
# * The sentence to examine (e.g. "a-b c! d,e")
# Returns:
# * The number of space-delimited tokens that are valid according to the stated
#   criteria (e.g. 2)
################################################################################
sub count_valid_tokens{
    my @tokens = split(" ", shift());

    my $valid = 0;

    foreach my $token (@tokens){
        # Skip this token if...
        next
            if(
                # ...it has any digits...
                $token =~ m/\d/
                ||

                # ...or if it has more than one hyphen or a
                # hyphen that isn't surrounded by lower-case
                # letters...
                (
                    $token =~ m/-/
                    &&
                    ($token =~ m/(-).*\1/ || $token !~ m/[a-z]-[a-z]/)
                )
                ||

                # ...or it has more than one of the specified
                # punctuation marks, or that punctuation mark
                # is not at the end of the token
                (
                    $token =~ m/[.,!]/
                    &&
                    ($token =~ m/([.,!]).*\1/ || $token !~ m/[.,!]$/)
                )
            );

        # Not skipped, this token must be valid
        $valid++;
    }

    return($valid);

}



