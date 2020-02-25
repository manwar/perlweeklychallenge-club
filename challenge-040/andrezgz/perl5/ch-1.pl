#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-040/
# Task #1
# Show multiple arrays content
# You are given two or more arrays. Write a script to display values of each list at a given index.
#
# For example:
#
# Array 1: [ I L O V E Y O U ]
# Array 2: [ 2 4 0 3 2 0 1 9 ]
# Array 3: [ ! ? £ $ % ^ & * ]
# We expect the following output:
#
# I 2 !
# L 4 ?
# O 0 £
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *

use strict;
use warnings;

use v5.20;
use feature qw(postderef);
no warnings qw(experimental::postderef);

my @arrays = (
    [qw/ I L O V E Y O U /],
    [qw/ 2 4 0 3 2 0 1 9 /],
    [qw/ ! ? £ $ % ^ & * /]
);

my $max=0;
for (@arrays) {
    $max = $_->@* if ($_->@* > $max);
}

for my $i (0.. $max - 1) {
    print $_->[$i].' ' for @arrays;
    print $/;
}
