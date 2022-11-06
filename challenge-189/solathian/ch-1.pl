#!usr/bin/perl -w
use strict;
use warnings;

use feature qw(say signatures);
no warnings qw(experimental);

my $testsEnabled = 0;
# Task 1: Greater Character

# You are given an array of characters (a..z) and a target character.
# Write a script to find out the smallest character in the given array lexicographically greater than 
# the target character.

sub greaterChar($target, @array)
{
    say("\nOutput:");
    $target = ord($target);   
    @array  = sort @array;
    
    # convert the ASCII character to their numerical value, keep only the values in the array which are greater than the target
    @array  = map{ $_  = ord($_)} grep{ ord($_) > $target} @array;
    
    # since the array is sorted the first value, if it exists shall contain the smallest character which is greater than the target
    say( chr($array[0])) if(defined $array[0]);

}

# Examples:
my @tArray0 = qw/e m u g/;
my $target0 = 'b';

greaterChar($target0, @tArray0)   if($testsEnabled);
# Output: e


my @tArray1 = qw/d c e f/;
my $target1 = 'a';
greaterChar($target1, @tArray1)   if($testsEnabled);
# Output: c


my @tArray2 = qw/j a r/;
my $target2 = 'o';
greaterChar($target2, @tArray2)   if($testsEnabled);
# Output: r


my @tArray3 = qw/d c a f/;
my $target3 = 'a';
greaterChar($target3, @tArray3)   if($testsEnabled);
# Output: c


my @tArray4 = qw/t g a l/;
my $target4 = 'v';
greaterChar($target4, @tArray4)   if($testsEnabled);
# Output: v                         #  <- the last example is wrong or shall I output the target, if no match is found?
