#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @scores = (4, 5);

# Uncomment this list instead if you
# want to see some epic sets of
# permutations- 121415 and 53798080
# respectively
# my @scores = (20, 30);

foreach(@scores){
    print("Score: $_\n");
    print("Permutations:\n");
    print_score_permutations($_);
    print("\n");
}


exit(0);
################################################################################
# End of main execution; subroutines follow
################################################################################



################################################################################
# Calculate all the permutations of baskets (free throws worth one point,
# regular baskets worth two, three-pointers worth, er, three) that add up to a
# particular specified basketball score, and write each basket sequence to
# STDOUT
# Takes one argument:
# * The score to examine
# Writes output to STDOUT
# Returns no meaningful value
################################################################################
sub print_score_permutations{
    my $score = shift();

    my $shot_stack = [];

    _score_recursor($score, $shot_stack);

}



################################################################################
# The recursive core of the score permutation calculator
# Takes two arguments:
# * The number of points not yet accounted for
# * A reference to a list of shots already examined, which will be treated as a
#   stack by the various recursive calls to this function; when the contents of
#   the stack add up to the total score specified in the call to
#   print_score_permutations(), the contents will be written to STDOUT
# Writes output to STDOUT
# Returns no meaningful value
# NOTE: This should ONLY be called by score_permutations(), which does some
# initial setup
################################################################################
sub _score_recursor{
    my $score = shift();
    my $shot_stack = shift();

    my $shot;

    foreach $shot (1, 2, 3){
        # No need to proceed if the value of
        # the current shot exceeds the number
        # of points remaining
        last if($shot > $score);

        # Push the current shot onto the shot
        # stack
        push(@{$shot_stack}, $shot);

        if($score - $shot){
            # Subtracting this basket, the score
            # is nonzero- go a level deeper with
            # the new score
            _score_recursor($score - $shot, $shot_stack);
        } else{
            # The subtracted score is zero-
            # print out a copy of the current
            # shot stack
            print("    ", join(" ", @{$shot_stack}), "\n");
        }

        # Pop the shot stack
        pop(@{$shot_stack});
    }

}



