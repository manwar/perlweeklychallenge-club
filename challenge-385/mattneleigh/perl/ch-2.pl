#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "()()()",
    "(((())))",
    "(()())(())",
    "()((()))()",
    "(()(()))(()())"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        remove_outermost_parens($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string with groups of matched (and possibly nested) parentheses,
# delete the outermost matched sets of parentheses from the entire string
# Takes one argument:
# * A string to examine for blocks of parentheses (e.g. "(()(()))(()())")
# Returns:
# * The provided string with all of the outermost parentheses removed from each
#   substring containing matched sets of parentheses (e.g. "()(())()()")
################################################################################
sub remove_outermost_parens{
    my $string = shift();

    my $pos = 0;
    my $paren_level = 0;
    my $last_outermost;

    # Loop over every character in the string
    # (which is likely to be shrinking)
    while($pos <= length($string)){
        if(substr($string, $pos, 1) eq "("){
            # This open-paren increases the paren level
            if(!$paren_level){
                # The paren level was zero; make a note of
                # this position as the last outermost paren
                # seen
                $last_outermost = $pos;
            }
            $paren_level++;

            # Advance the current position within the
            # string
            $pos++;
        } elsif(substr($string, $pos, 1) eq ")"){
            # This close-paren reduces the paren level
            $paren_level--;
            if(!$paren_level){
                # This close-paren brought the paren level to
                # zero; delete this closee-paren from the
                # string as well as the previous outermost
                # open-paren 
                substr($string, $pos, 1, "");
                substr($string, $last_outermost, 1, "");

                # Move the current position back one
                # character, which advances it one place
                # after compensating for the deletions
                $pos--;
            } else{
                # Paren level is not zero; advance the
                # current position within the string
                $pos++;
            }
        } else{
            # Not a parentheses; advance the current
            # position within the string
            $pos++;
        }
    }

    return($string);

}



