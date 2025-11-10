#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @paren_strings = (
    "(()())",
    ")()())",
    "((()))()(((()",
    "))))((()(",
    "()(()"
);

print("\n");
foreach my $paren_string (@paren_strings){
    printf(
        "Input: \$str = '%s'\nOutput: %d\n\n",
        $paren_string,
        length_of_longest_valid_parens($paren_string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting only of opening ('(') and closing (')') parentheses
# characters, determine the maximum run of valid matched parentheses, taking
# into account situations in which adjacent valid sets occur (i.e.
# "(...)(...)")
# Takes one argument:
# * The string to examine (e.g. "((()))()(((()")
# Returns:
# * The length of the longest continuous run of valid matched pairs (e.g. 8)
################################################################################
sub length_of_longest_valid_parens{
    my @chars = split(//, shift());

    my $i;
    my @open_parens;
    my $prev_end = 0;
    my $total = 0;
    my $max = 0;

    # Loop over each character
    foreach $i (0 .. $#chars){
        if($chars[$i] eq '('){
            # Open paren:
            # Store this open paren's location on the stack
            push(@open_parens, $i);
        } elsif(@open_parens){
            # Close paren AND at least one open paren remains:
            if($prev_end == $open_parens[-1] - 1){
                # This substring is adjacent to the previous one;
                # add its length to the total
                $total += $i - $open_parens[-1] + 1;
            } else{
                # This substring is NOT adjacent to the previous
                # one; set the total to its length
                $total = $i - $open_parens[-1] + 1;
            }

            # Update the maximum length if required
            $max = $total
                if($total > $max);

            # Make a note of where this substring ended, and
            # pop this open paren's location from the stack
            $prev_end = $i;
            pop(@open_parens);
        }
    }

    return($max);

}



