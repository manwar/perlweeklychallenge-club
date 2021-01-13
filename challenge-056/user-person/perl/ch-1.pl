#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/         #
#                                                                         #
# Diff-K                                                                  #
# You are given an array @N of positive integers (sorted) and another     #
# non negative integer k.                                                 #
# Write a script to find if there exists 2 indices i and j such that      #
# A[i] - A[j] = k and i != j.                                             #
#                                                                         #
# It should print the pairs of indices, if any such pairs exist.          #
#                                                                         #
# Example:                                                                #
#                                                                         #
#         @N = (2, 7, 9)                                                  #
#         $k = 2                                                          #
#                                                                         #
# Output : 2,1                                                            #
#                                                                         #
###########################################################################

use strict;
use warnings;

my @n = (2, 7, 9);
my $k = 2;
my @match = ();

for (my $i = $#n;$i > 0; --$i) {

    my $diff = $n[$i] - $k;

    for (my $j = $i-1; $n[$j] >= $diff ; --$j) {
        if ($n[$j] == $diff && $i != $j) {
            push @match, "($i, $j)";
        }
    }
}

print "$_ " foreach reverse @match;
print "\n";

__END__
output:

(2, 1) 
