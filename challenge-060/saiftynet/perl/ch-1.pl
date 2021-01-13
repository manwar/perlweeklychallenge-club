#!/usr/env/perl
# Task 1 Challenge 060 Solution by saiftynet
# Excel Column... Reviewed by: Ryan Thompson
# Write a script that accepts  a number and returns the Excel Column
# Name it represents and vice-versa.
# Excel columns start at A and increase lexicographically using 
# the 26 letters of the English alphabet, A..Z. After Z, the columns 
# pick up an extra &ldquo;digit&rdquo;, going from AA, AB, etc., 
# which could (in theory) continue to an arbitrary number of digits. 
# In practice, Excel sheets are limited to 16,384 columns.
# Example
# Input Number: 28 Output: AB   Input Column Name: AD  Output: 30


# Function and its inverse in one subroutine.  
# The columns notation is a base 26 transformation of the
# column as number, with "Z" effectively the zero equivalent;
# i.e the equivalent of (0..9) is essentially (Z,A..Y).
# Excel has a limit of 16384, the routine allows outside this value
# but indicates the error with a "*"

# test a number of possible inputs
foreach my $test (qw/1000 A KVZ 12 1337 16384 PERL/){
   printf "*  %8s converted is  %8s and again is %8s \n",
         $test, xlcolumn($test),  xlcolumn(xlcolumn($test));
}

sub xlcolumn{
  my $in=shift;
  $in=~s/\*//;                    # (remove error character)
  if ($in=~/^\d+$/){              # if a number was entered
    my $error= $in>16384?"*":"";
    my $ret="";                   # start with an empty string
    while ($in){                  # until no residue
      # get character for residue the modulo 26
      $ret= (("Z","A".."Y"))[$in % 26] . $ret; 
      $in=($in-($in % 26))/26;    # remove the modulo and divide by 26
    }
    return $ret.$error;
  }
  elsif ($in=~/^[A-Z]+$/){        # if an alphabetic character entered
    my $ret=0;                    # start with zero
    foreach (split //,$in){       # each character taken
       $ret*=26;                  # multiply by 26 
       # and add the number equivalent of next character
       $ret+=index("ZABCDEFGHIJKLMNOPQRSTUVWXY",$_) 
    }
    return $ret.($ret>16384?"*":""); 
  }
  return "failed";
}
