#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/         #
#                                                                         #
# kth Permutation Sequence                                                #
# Write a script to accept two integers n (>=1) and k (>=1).              #
# It should print the kth permutation of n integers.                      #
# For more information, please follow the wiki page.                      #
# https://en.wikipedia.org/wiki/Permutation#k-permutations_of_n           #
# For example, n=3 and k=4,                                               #
# the possible permutation sequences are listed below:                    #
#                                                                         #
#   123                                                                   #
#   132                                                                   #
#   213                                                                   #
#   231                                                                   #
#   312                                                                   #
#   321                                                                   #
# The script should print the 4th permutation sequence 231.               #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;

use FindBin;                   
use List::Permutor;

sub msgExit {
    print $FindBin::Script . " requires 2 arguments. The first argument to determine the sequence ( 1 >= ),
The second argument to determine which entry to print. Both arguments should be >= 1 .\n";
    exit(1);
}

msgExit if scalar @ARGV != 2;

my $n = $ARGV[0];
my $k = $ARGV[1];

if ( $n =~ m{\A\d+\Z} and $k =~ m{\A\d+\Z} ) {
    if ($n < 1 or $k < 1) {
        msgExit;
    }
} else {
    msgExit;
}
my @sequence = 1 .. $n-1;

my $perm = new List::Permutor @sequence;

my $kth = 1;

my $failure++;

LOOP:
while (my @set = $perm->next) {
    if ( $kth++ == $k) {
        print @set, "\n";
        $failure--;
        last LOOP;
    }
}

print "There is no '$k'-th number in the '$n sequence'.\n" if $failure;

endHandler() if $reporting || $logging; # TO CLEAN UP, AND CLOSE LOG ENTRIES
