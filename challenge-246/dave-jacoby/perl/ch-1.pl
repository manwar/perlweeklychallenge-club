#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my %hash;


# Write a script that outputs six unique random integers 
# from the range 1 to 49.

# I had missed 'unique', which means we have to be sure we
# deal with duplicates. Use the random number as keys to a hash
# and you won't get duplicates.

# Adding the numeric sort just makes it pretty.

while ( scalar keys %hash < 6 ) {
    my $n = 1 + int rand 49;
    $hash{$n} = 1;
}

say join "\n", sort { $a <=> $b } keys %hash;

# And here is my first pass, which ignored "unique". 
# Because of that, it was very simple.

# say join "\n",
#     sort { $a <=> $b }      # and the example is sorted numerically, so we will
#     map { 1 + int rand 49 } # which are random and between 1 and 49
#                             # but int rand ( n ) will give a number between 0 and n-1
#                             # so adding 1 will put it at the right range
#     1 .. 6;                 # we want six numbers
