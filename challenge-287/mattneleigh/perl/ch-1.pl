#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @passwords = (
    "a",
    "aB2",
    "PaaSW0rd",
    "Paaasw0rd",
    "aaaaa"
);

print("\n");
foreach my $password (@passwords){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $password,
        steps_to_strong_password($password)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a prospective password, determine the minimum number of steps required
# to convert the string to a "secure" password; if the password is already
# "secure" according to the criteria below, 0 is returned
#
# Security criteria:
# * The password must have at least six characters
# * The password must contain at least one lowercase letter, at least one upper
#   case letter, and at least one digit
# * The password must not contain three repeating characters in a row
# 
# Each of the following operations can be considered one step:
# * Inserting one character
# * Deleting one character
# * Replacing one character with another
# 
# Takes one argument:
# * The prospective password to examine (e.g. "aaaaa" )
# Returns:
# * The number of steps, as defined above, required to make the prospective
#   password secure (e.g. 2 )
################################################################################
sub steps_to_strong_password{
    my $string = shift();

    my $chars_subbed = 0;
    my $chars_added = 0;
    my $blocks_of_three = 0;

    # Check to see whether we need upper case, lower
    # case, or digits, respectively, and add up the
    # total desired additions/substitutions of each
    # type
    $chars_subbed++
        unless($string =~ m/[[:upper:]]/);
    $chars_subbed++
        unless($string =~ m/[[:lower:]]/);
    $chars_subbed++
        unless($string =~ m/\d/);

    # See if additional characters are needed to meet
    # the length requirement
    $chars_added += 6 - length($string)
        if(length($string) < 6);

    # See if we have a block of three repeated chars...
    if($string =~ m/(.)\1{2}/g){
        $blocks_of_three = 1;

        # See if we have multiple blocks of three repeated
        # chars...
        while($string =~ m/\G(.)\1{2}/g){
            $blocks_of_three++;
        }
    }

    # If the password is not long enough, we add enough
    # characters to fit the requirements- all of which
    # can be needed substitute characters so we
    # subtract this from the quantity of required
    # substitutions
    $chars_subbed -= $chars_added;

    # Similarly, if we have to replace characters to
    # break up blocks of three characters, we can use
    # needed substitute characters, so we subtract from
    # the substitution count again
    $chars_subbed -= $blocks_of_three;

    return(
        $blocks_of_three
        +
        $chars_added
        +
        (
            # If we subtracted all (or more than all...) of the
            # substitution characters, use zero for this term
            $chars_subbed > 0 ?
                $chars_subbed
                :
                0
        )
    );

}



