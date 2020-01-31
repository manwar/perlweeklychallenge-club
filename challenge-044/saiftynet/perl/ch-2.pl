#!/usr/env perl
# Perl Weekly Challenge             Challenge 044 Task 2
# You have only $1 left at the start of the week. You have been given an
# opportunity to make it $200. The rule is simple with every move you
# can either double what you have or add another $1. Write a script to
# help you get $200 with the smallest number of moves.
#
# This soloution extends to allow any start and any target

use strict; use warnings;

doubleOrAdd(1,200);     # The main call: Give a start and the target,   
                        # returns the results to console

sub doubleOrAdd{        # this routine takes starting value and final target
  my ($start,$target)=@_;
  
  return print "Number out of bounds\n"         # too big takes too long and
         if $target>100000 or $target<$start;   # can't be smaller than $target
  
  my @options=("$start");                       # initialise list of operations,
  my $found=($start==$target);                  # do we already have goal?
  
  while (! $found){
	  @options = map {("($_+1)","($_*2)")} @options; # add the two possible ops
	  foreach  my $answer ( @options ) {      # test each of the sequences
		if ( eval("$answer")==$target) {      # against our target
			                            
			# if found, announce it                               
			# the answer will look like  (((((((((1+1)+1)*2)*2)*2)+1)*2)*2)*2)
			# to make it easier to read, we will translate it to English
			                         
			# number of moves is count of open brackets,remove these.			                               
			print $answer=~s/\(//g," moves required\n"; 
			
			$answer=~s/^(\d+)/Start with \$$1,\n/;   # the starting number is 1st number
			$answer=~s/\+1\)/ add 1,\n/g;            # make the result human
			$answer=~s/\*2\)/ double it,\n/g;        # readable:
			
			print $answer;
			
			
			$found=1;last;                           # stop looking
		};
      };
    }
    print " Now you have \$$target!";                # declare discovery
}

##     Output
# 9 moves required
# Start with $1,
#  add 1,
#  add 1,
#  double it,
#  double it,
#  double it,
#  add 1,
#  double it,
#  double it,
#  double it,
#  gives you $200


