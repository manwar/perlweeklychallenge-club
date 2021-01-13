#!/usr/env/perl
# Task 2 Challenge 050 Solution by saiftynet
# Contributed by Ryan Thompson.Noble Integer
# You are given a list, @L, of three or more random integers between 
# 1 and 50. A Noble Integer is an integer N in @L, such that there 
# are exactly N integers greater than N in @L. Output any Noble 
# Integer found in @L, or an empty list if none were found.
# An interesting question is whether or not there can be multiple 
# Noble Integers in a list.
# For example,
# Suppose we have list of 4 integers [2, 6, 1, 3].
# Here we have 2 in the above list, known as Noble Integer, since 
# there are exactly 2 integers in the list i.e.3 and 6, which are 
# greater than 2.
# Therefore the script would print 2.

# The first part of the solution generates random lists to test
# The list generator is configurable with random sizes and contents
# The number of tests to be performed can also be set below
my $maxListLength   =  15 ;
my $minListLength   =   3 ;
my $minIntSize      =   1 ;
my $maxIntSize      =  20 ;
my $numberOfTests   =  15 ;

foreach (0..$numberOfTests ){
  @list=();
  push @list,int(rand()*($maxIntSize-$minIntSize)+$minIntSize)
  foreach (0..(rand()*($maxListLength-$minListLength)+$minListLength));
  findNobel(@list);
}

# The findNobel function, as one might expect, finds the nobel number.
# The answer to the question of whether there can be more than 1 nobel
# number is "NO".  A list with a noble number N has N elements with
# greater value than N.  Any of the numbers which are greater than N
# will therefore have less than N numbers greater than themselves. As
# a number can not be both greater and less than N at the same time,
# only one possible nobel number can exist for any list.

sub findNobel{
  @l=sort{$a<=>$b} @_;	# sort the list first
  $found=0;             # intialise $found to zero
  foreach(0..$#l){      # look through elements
    # when a nobel element is found, report, set $found and exit
    print "Found Nobel Number $l[$_] " and $found=1 and last if $l[$_]==($#l-$_);
  }
  print "No Nobel numbers" unless $found;   # $found not set if not found
  print   " in ".(join ",",@l),"\n";        # either way, print out the list
}

