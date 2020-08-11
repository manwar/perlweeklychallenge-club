#!/usr/env/perl
# Task 1 Challenge 058 Solution by saiftynet
# Compare two given version number strings v1 and v2 such that:
# 
# If v1 > v2 return 1
# If v1 < v2 return -1
# Otherwise, return 0
# The version numbers are non-empty strings containing only digits,
# and the dot (“.”) and underscore (“_”) characters. (“_” denotes
# an alpha/development version, and has a lower precedence than
# a dot, “.”). Here are some examples:

#    v1   v2    Result
#   0.1 < 1.1     -1
#   2.0 > 1.2      1
#   1.2 < 1.2_5   -1
# 1.2.1 > 1.2_1    1
# 1.2.1 = 1.2.1    0

use strict; use warnings;

# use examples specified in task to test,
foreach my $pair ([ "0.1" , "1.1"   ],
                  [ "2.0" , "1.2"   ],
                  [ "1.2" , "1.2_5" ],
                  ["1.2.1" , "1.2_1"],
                  ["1.2.1" , "1.2.1"]){
    printf " %6s %s %-6s  %2s\n",  $$pair[0],
          ("=",">","<")[compareVersions($$pair[0],$$pair[1])],
          $$pair[1], compareVersions($$pair[0],$$pair[1]);
}

sub compareVersions{  # takes two version strings
  # split each string by ".", then each result by "_"; 
  my @aBits=map{my @tmp=split /_/,$_;($tmp[0],$tmp[1]//0)} (split /\./,shift);
  my @bBits=map{my @tmp=split /_/,$_;($tmp[0],$tmp[1]//0)} (split /\./,shift);
  my $result=0;
  while(1) {
   # compare each segment using <=>
   $result=(shift @aBits<=>shift @bBits);
   # leave if different
   last if $result or not(scalar @aBits and scalar @bBits);
   # if there is an alpha version add it fractionally to next segment
   # expecting less than 100 alpha versions
   $aBits[1]+=$aBits[0]/100;shift @aBits; 
   $bBits[1]+=$bBits[0]/100;shift @bBits;
  }
  return $result;
}
