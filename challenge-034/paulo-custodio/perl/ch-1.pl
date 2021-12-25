#!/usr/bin/perl

# Challenge 034
#
# Task #1
# Contributed by Dave Cross
# Write a program that demonstrates using hash slices and/or array slices.

use Modern::Perl;

my %data = (oranges => 3, pears => 2, apples => 4);
my @values = @data{qw(oranges apples)};
say join(", ", @values);
