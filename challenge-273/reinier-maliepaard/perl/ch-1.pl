#!/usr/bin/perl
use strict;
use warnings;

sub percentage_of_character {

  my ($str, $char) = (@_);

  # create a new Statistics::Frequency object.
  my $f = Statistics::Frequency->new( split(//, $str) );
  return( int( ($f->proportional_frequency($char) * 100) + 0.5) );

}

#TESTS

my ($str, $char);

# Example 1
$str = "perl";
$char = "e";
print(percentage_of_character($str, $char), "\n"); # Output: 25

# Example 2
$str = "java";
$char = "a";
print(percentage_of_character($str, $char), "\n"); # Output: 50

# Example 3
$str = "python";
$char = "m";
print(percentage_of_character($str, $char), "\n"); # Output: 0

# Example 4
$str = "ada";
$char = "a";
print(percentage_of_character($str, $char), "\n"); # Output: 67

# Example 5
$str = "ballerina";
$char = "l";
print(percentage_of_character($str, $char), "\n"); # Output: 22

# Example 6
$str = "analitik";
$char = "k";
print(percentage_of_character($str, $char), "\n"); # Output: 13
