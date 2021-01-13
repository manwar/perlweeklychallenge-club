#!/usr/env/perl
# Task 2 Challenge 063 Solution by saiftynet
#  › Rotate String
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
# Given a word made up of an arbitrary number of x and y 
# characters, that word can be rotated as follows: For the ith rotation 
# (starting at i = 1), i % length(word) characters are moved from 
# the front of the string to the end. Thus, for the string xyxx, 
# the initial (i = 1) % 4 = 1 character (x) is moved to the end, 
# forming yxxx. On the second rotation, (i = 2) % 4 = 2 characters 
# (yx) are moved to the end, forming xxyx, and so on. See below 
# for a complete example.
# Your task is to write a function that takes a string of xs and 
# ys and returns the minimum non-zero number of rotations required 
# to obtain the original string. You may show the individual rotations 
# if you wish, but that is not required.


# Fairly straight forward to rotate a string using substr
# to demonstrate the transforms that are occuring the routine
# offers an optional verbose mode allowing outputing of each
# transform.  Further clarity may be obtained by using the
# optional colour parameter suitable for ANSI capable terminals.
# Call using `rotateString($string,[$verbose],[$colour])`
# There does not appear any need to confine the string to 
# just "x" and "y"....this works with any string.

# demos 3 modes
# 1) without commentary
print "\n   ". rotateString("xyxx"),                    " rotations required.\n";

# 2) with commentary 
print "\n   ". rotateString("I am spinning around!",1), " rotations required.\n";

# 3) decorated commentary if Terminal accepts ANSI escape codes
print "\n   ". rotateString("Madam I am Adam",1,1),     " rotations required.\n";

sub rotateString{
  my ($origStr,$verbose,$colour)=@_;
  # if $verbose defined and true then outputs transforms
  # if $verbose and $colour are true then colour transforms
  my $workStr=$origStr;
  my $count=0;       # count of moves
  do{                # do means loop run at least once
    $count++;
    print "\n$count $workStr -> " if $verbose;   # before rotation
    $workStr=($colour?"\e[31m":"").substr($workStr,$count%length $workStr).  
             ($colour?"\e[32m":"").substr($workStr,0,$count%length $workStr).
             ($colour?"\e[0m" :"");
    print $workStr if $verbose;
    $workStr=~s/\e\[[^m]+m//g;
    
  }while($origStr ne $workStr);
  return $count;
}

