#!/usr/bin/env perl
# Perl Weekly Challenge Week 034 Task 1
# Write a program that demonstrates using hash slices and/or array
# slices.

use strict;
use warnings;
use feature qw/ say /;

# Array slices
my @all_staff =
  qw/ fry professor leela bender amy hermes zoidberg nibbler zapp kif/;

say "@all_staff\n";

# slicing the first, third and fifth elements from an array
say "@all_staff[0, 2, 4]";

# slicing a range of elements from an array
say "@all_staff[1..4]";

# the first and last element from an array counting from the end
say "@all_staff[0,-1]";

# picking out elements in different order
say "@all_staff[4,1,0]";

# Hash slice
my %staff_ages = (
    fry       => 10025,
    professor => 92,
    leela     => 28,
    bender    => 12,
    amy       => 23,
);

my @staff = qw/ fry professor amy /;

say "\nStaff present were: @staff";
say "Their ages were: @staff_ages{ @staff }";

