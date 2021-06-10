#!/usr/bin/perl
# 
# Task 1: "Locate Memory
# 
# Write a script to declare a variable or constant and print it's location in
# the memory.
# "
# 
# My notes: umm, does this just mean "use \ and %p", or something more subtle?
# 

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: locate-memory val\n" unless @ARGV==1;

my $x = shift;
my $refx = \$x;
printf "address of $x is %p\n", $refx;
