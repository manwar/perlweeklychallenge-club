#!/usr/env/perl
# Task 2 Challenge 051 Solution by saiftynet
# Colourful Number
# Write a script to display all Colorful Number with 3 digits.
# A number can be declare Colorful Number where all the products 
# of consecutive subsets of digit are different.
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 
# 2x6x3 are unique.

# Relatively easy to get colourful for 3 digit numbers...only 6 
# possible consecutive products possible.
# uniqueness is obtained most easily by setting products as
# keys of hash.  if the number of keys equals the number of products
# then all products are unique 

# for all 3 digit colourful numbers...
print "3 digit colourful numbers \n";
foreach(100..999){  #all possible three digit numbers
  my ($d1,$d2, $d3)=split //, $_;
  my %l=(); # uniqueness is checked by making keys of a hash
            # all the possible consecutive products
  @l{$d1, $d2, $d3, $d1*$d2,$d2*$d3,$d1*$d2*$d3}=1x6;
  
  # if number of keys is 6, then no duplicates exist
  print  "$d1$d2$d3 " if 6 == keys %l; 
}

print "\n\n";

# clearly no colourful number can contain 1 or 0,
# and no duplicate digits can exist, but testing for 
# these exclusion just makes the code more messy

# testing a more generic test for colourfulness
# (i.e not restricted to 3 digits...). Here we test
# for all such numbers between 22000 and 24000
print "Colourful numbers between 22000 and  24000 \n";
foreach(22000..24000){
 print "$_ " if testColourful($_);
}


#  the following  will test any number for colourfulness 
sub testColourful{
   my %products=();
   my @digits=split //, shift;
   # get all possible combinations of consecutive products
   # with each possible start point keep multiplying next digits,
   # storing the result as a key in %products
   foreach my $startDigit (0..$#digits){
        my $p=1;
        foreach (0..$#digits-$startDigit){
           $p*=$digits[$startDigit+$_];
           $products{$p}++;
        }
   }
   # there are n(n+1)/2 possible consecutive digits
   # return if the number of combination matches number of products 
   return keys %products==@digits*(@digits+1)/2;
}
