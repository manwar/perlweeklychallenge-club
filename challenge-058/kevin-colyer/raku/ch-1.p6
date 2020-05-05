#!perl6
# Task 1 Challenge 058 Solution by kevincolyer

# TASK #1 › Compare Version
# Reviewed by Ryan Thompson
# Compare two given version number strings v1 and v2 such that:
# 
# If v1 > v2 return 1
# If v1 < v2 return -1
# Otherwise, return 0
# The version numbers are non-empty strings containing only digits, and the dot (“.”) and underscore (“_”) characters. (“_” denotes an alpha/development version, and has a lower precedence than a dot, “.”). Here are some examples:
# 
#    v1   v2    Result
# ------ ------ ------
#   0.1 < 1.1     -1
#   2.0 > 1.2      1
#   1.2 < 1.2_5   -1
# 1.2.1 > 1.2_1    1
# 1.2.1 = 1.2.1    0
# Version numbers may also contain leading zeros. You may handle these how you wish, as long as it’s consistent.

# compares versions numbers of type major,minor,revision. 
# Assumes max of 500 revisions and 1000 minor versions.
sub compare-versions(Str $v1 is copy, Str $v2 is copy) returns Int {

    # convert maj to maj,min,revision
    $v1 ~= ".0.0" if $v1 ~~ /^ \d+ $/;
    $v2 ~= ".0.0" if $v2 ~~ /^ \d+ $/;
    # convert maj,min to maj,min,revision
    $v1 ~= ".0" if $v1 ~~ /^ \d+ \. \d+ $/;
    $v2 ~= ".0" if $v2 ~~ /^ \d+ \. \d+ $/;
    
    # flag if development version
    my $dev1 = $v1 ~~ /_/ ?? 1 !! 0;
    my $dev2 = $v2 ~~ /_/ ?? 1 !! 0;
    
    # convert maj, min, revision a numeric value 
    # double revision value and reduce by 1 if development version 
    my ($a,$b,$c)=$v1.split(/ \. | _ /);
    $c=0 if ! $c.defined;
    my $val1=($a*1000+$b)*1000+$c*2-$dev1;
    
    ($a,$b,$c)  = $v2.split(/ \. | _ /);
    $c=0 if ! $c.defined;
    my $val2=($a*1000+$b)*1000+$c*2-$dev2;

    return 1  if $val1 > $val2;
    return -1 if $val1 < $val2;
    return 0;
}

use Test;
is compare-versions(   "0.1","1.1"  )   ,-1, "   0.1 < 1.1  ";
is compare-versions(   "2.0","1.2"  )   , 1, "   2.0 > 1.2  ";
is compare-versions(   "1.2","1.2_5")   ,-1, "   1.2 < 1.2_5";
is compare-versions( "1.2.1","1.2_1")   , 1, " 1.2.1 > 1.2_1";
is compare-versions( "1.2.1","1.2.1")   , 0, " 1.2.1 = 1.2.1";
# edge case
is compare-versions( "2","1.2.1")       , 1 , "edge case 2 > 1.2.1";
is compare-versions( "2","1.2_1")       , 1 , "edge case 2 > 1.2_1";

is compare-versions( "2.1","2_1")       , 1 , "edge case 2.1 > 2_1";
is compare-versions( "1","2")           ,-1 , "edge case 1 < 2";
