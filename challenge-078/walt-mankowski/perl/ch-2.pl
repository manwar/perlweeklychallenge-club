#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Left Rotation
# Submitted by: Mohammad S Anwar
#
# You are given array @A containing positive numbers and @B containing
# one or more indices from the array @A.
#
# Write a script to left rotate @A so that the number at the first
# index of @B becomes the first element in the array. Similary, left
# rotate @A again so that the number at the second index of @B becomes
# the first element in the array.

my @a = split / /, $ARGV[0];
my @b = split / /, $ARGV[1];

for my $b (@b) {
    local $, = " ";
    say rotate_by($b, @a);
}

sub rotate_by($b, @a) {
    return $b == 0 ? @a : (@a[$b..$#a], @a[0..$b-1]);
}
