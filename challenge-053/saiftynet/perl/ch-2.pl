#!/usr/env/perl
# Task 2 Challenge 053 Solution by saiftynet
# Vowel Strings
# Write a script to accept an integer 1 > N > 5 that would 
# print all possible strings of size N formed by using only vowels 
# (a, e, i, o, u).
# The string should follow the following rules:
# ‘a’ can only be followed by ‘e’ and ‘i’.
# ‘e’ can only be followed by ‘i’.
# ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
# ‘o’ can only be followed by ‘a’ and ‘u’.
# ‘u’ can only be followed by ‘o’ and ‘e’.
# For example, if the given integer N = 2 then script should print 
# the following strings:
# ae ai ei ia io iu ie oa ou uo ue

# This script takes an integer either as a command line parameter, or
# if no parameters offered, requests the integer from the user. It then
# displays all the vowel strings with that many characters 

my $target=$ARGV[0];                       # command line parameters
print "Enter the string length  >> "       # Prompts for input
  and chomp($target=<>) unless $target;    # if parameter not supplied
                          
print join (" ",vowelStrings($target));    # display returned list

sub vowelStrings{
  my $target=shift;
  my %following=(      # hash containing lists of valid following vowels
    a =>['e','i'],
    e =>['i'],
    i =>['a', 'e', 'o', 'u'],
    o =>['a', 'u'],
    u =>['o','e'],
  );
  my @list=(qw{a e i o u }); # start with list of vowels

# treats @list as a circular list shifting a string from one end,
# create a list made by adding all the potential following vowels
# to that string, and pushing these to the end, continuing until
# $target length achieved

  while(length $list[0] <$target){
    my $str= shift @list;
    push @list, map {$str.$_} @{$following{substr($str,-1,1)}};
  }
  return @list,
}
