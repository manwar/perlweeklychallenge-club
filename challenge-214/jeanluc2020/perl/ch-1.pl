#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-214/#TASK1
#
# Task 1: Rank Score
# ==================
#
# You are given a list of scores (>=1).
#
# Write a script to rank each score in descending order. First three will get
# medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the
# ranking number.
#
#     Using the standard model of giving equal scores equal rank, then
#     advancing that number of ranks.
#
## Example 1
##
## Input: @scores = (1,2,4,3,5)
## Output: (5,4,S,B,G)
##
## Score 1 is the 5th rank.
## Score 2 is the 4th rank.
## Score 4 is the 2nd rank i.e. Silver (S).
## Score 3 is the 3rd rank i.e. Bronze (B).
## Score 5 is the 1st rank i.e. Gold (G).
#
## Example 2
##
## Input: @scores = (8,5,6,7,4)
## Output: (G,4,B,S,5)
##
## Score 8 is the 1st rank i.e. Gold (G).
## Score 4 is the 4th rank.
## Score 6 is the 3rd rank i.e. Bronze (B).
## Score 7 is the 2nd rank i.e. Silver (S).
## Score 4 is the 5th rank.
#
## Example 3
##
## Input: @list = (3,5,4,2)
## Output: (B,G,S,4)
#
## Example 4
##
## Input: @scores = (2,5,2,1,7,5,1)
## Output: (4,S,4,6,G,S,6)
#
############################################################
##
## discussion
##
############################################################
#
# First, we fill a hash with the amount of hits for each score
# Then we sort the found scores and calculate their rank
# Then we put the rank of each element in the scores into
# the result array.

use strict;
use warnings;

rank_score(1,2,4,3,5);
rank_score(8,5,6,7,4);
rank_score(3,5,4,2);
rank_score(2,5,2,1,7,5,1);

sub rank_score {
   my @scores = @_;
   print "Input: (" . join (",", @scores) . ")\n";
   my %seen = ();
   my %ranks = ();
   my %medal = (
      1 => "G",
      2 => "S",
      3 => "B"
   );
   # How often do we have each score?
   foreach my $score (@scores) {
      $seen{$score}++;
   }
   # Starting with the first rank, we fill the ranks hash
   # If the rank is < 4 we have a medal, so let's assign that
   # from the %medal hash. Otherwise, we have a numbered rank
   # that we can assign directly
   my $rank = 1;
   foreach my $key (sort {$b<=>$a} keys %seen) {
      if($rank < 4) {
         $ranks{$key} = $medal{$rank};
      } else {
         $ranks{$key} = $rank;
      }
      $rank += $seen{$key};
   }
   # now we can put together the result
   my @result = ();
   foreach my $score (@scores) {
      push @result, $ranks{$score};
   }
   print "Output: (" . join(",", @result) . ")\n";
}

