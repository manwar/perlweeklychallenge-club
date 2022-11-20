#!usr/bin/perl -w
use strict;
use warnings;

use feature qw(say signatures);
no warnings qw(experimental);

my $testsEnabled = 0;
# Task 1: Capital Detection

# You are given a string with alphabetic characters only: A..Z and a..z.

# Write a script to find out if the usage of Capital is appropriate if it satisfies 
# at least one of the following rules:

# 1) Only first letter is capital and all others are small.
# 2) Every letter is small.
# 3) Every letter is capital.

sub capitalDetect($string)
{
    my $returnVal = 0;
    
    if( $string =~ /^[A-Z]{1}[a-z]+$/ )
    {
        $returnVal = 1;
    }
    elsif( $string =~ /^[a-z]+$/ )  # not letting empty string to be valid
    {
        $returnVal = 1;
    }
    elsif( $string =~ /^[A-Z]+$/ )  # not letting empty string to be valid
    {
        $returnVal = 1;
    }
    
    return $returnVal;
}

# Examples:
my $test0   = 'Perl';       #   1
my $test1   = 'TPF';        #   1
my $test2   = 'PyThon';     #   0
my $test3   = 'raku';       #   1

say capitalDetect($test0)   if($testsEnabled);
say capitalDetect($test1)   if($testsEnabled);
say capitalDetect($test2)   if($testsEnabled);
say capitalDetect($test3)   if($testsEnabled);
