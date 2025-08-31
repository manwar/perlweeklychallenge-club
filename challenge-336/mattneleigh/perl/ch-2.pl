#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @score_sets = (
    [ "5", "2", "C", "D", "+" ],
    [ "5", "-2", "4", "C", "D", "9", "+", "+" ],
    [ "7", "D", "D", "C", "+", "3" ],
    [ "-5", "-10", "+", "D", "C", "+" ],
    [ "3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+" ]
);

print("\n");
foreach my $scores (@score_sets){
    printf(
        "Input: \@scores = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$scores}
            )
        ),
        evaluate_scores(@{$scores})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of scores and instructional codes, evaluate the list and
# determine the resulting total score; scores may consist of the following:
# * + - An instruction to add the last two scores in the list together and
#       place the result at the end of the list, leaving the two added scores
#       in place (i.e. (...5, 10) --> (...5, 10, 15) )
# * C - An instruction to invalidate the last score and remove it from the
#       list (i.e. (...5, 10) --> (...5) )
# * D - An instruction to double the last score and place it at the end of the
#       list, leaving the value that was doubled in place as well (i.e.
#       (...5, 10) --> (...5, 10, 20)
# * An integer value to be added to the list 
# All values in the list will be summed after processing, and the resulting
# value returned
# Takes one argument:
# * The list of scores and instructions to examine (e.g.
#   ("3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+") )
# Returns:
# * The result of processing the scores and instructions as described above
#   (e.g. 128)
################################################################################
sub evaluate_scores{
    use List::Util qw(sum);

    my @scores;

    # Loop over every score or embedded opcode
    foreach my $score (@ARG){
        if($score eq '+'){
            # Sum opcode- add the sum of the last two
            # scores to the list
            push(@scores, $scores[-1] + $scores[-2]);
        } elsif($score eq 'C'){
            # Cancel opcode- remove the last score from
            # the list
            pop(@scores);
        } elsif($score eq 'D'){
            # Double opcode- double the last score and
            # add the result to the list 
            push(@scores, $scores[-1] * 2);
        } else{
            # A score- add it to the list
            push(@scores, $score);
        }
    }

    # Return the sum of the scores
    return(sum(@scores));

}



