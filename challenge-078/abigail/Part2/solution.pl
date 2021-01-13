#!/opt/perl/bin/perl

#
# Exercise:
# 
#   You are given array @A containing positive numbers and @B containing
#   one or more indices from the array @A.
#   Write a script to left rotate @A so that the number at the first index
#   of @B becomes the first element in the array. Similary, left rotate @A
#   again so that the number at the second index of @B becomes the first
#   element in the array.
#

#
# We will be reading the arrays from STDIN -- @A is one the first
# line, @B is on the second line.
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';

#
# Read @A and @B
#
chomp (my @A = split / / => scalar <>);
chomp (my @B = split / / => scalar <>);

#
# Print the rotations.
#
foreach my $index (@B) {
    local $, = " ";
    say @A [$index .. @A - 1, 0 .. $index - 1];
}


__END__
