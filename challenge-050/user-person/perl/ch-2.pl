#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/         #
#                                                                         #
# Noble Integer                                                           #
# You are given a list, @L, of three or more random integers between 1    #
# and 50. A Noble Integer is an integer N in @L, such that there are      #
# exactly N integers greater than N in @L. Output any Noble Integer       #
# found in @L, or an empty list if none were found.                       #
#                                                                         #
# An interesting question is whether or not there can be multiple Noble   #
# Integers in a list.                                                     #
#                                                                         #
# For example,                                                            #
#                                                                         #
# Suppose we have list of 4 integers [2, 6, 1, 3].                        #
#                                                                         #
# Here we have 2 in the above list, known as Noble Integer, since there   #
# are exactly 2 integers in the list i.e.3 and 6, which are greater than  #
# 2.                                                                      #
#                                                                         #
# Therefore the script would print 2.                                     #
#                                                                         #
###########################################################################

use strict;
use warnings;

sub nobleInt {
    my @ints = sort { $a <=> $b } @_;
    my %seen = ();
    for (my $i = 0; $i <= $#ints; ++$i) {
        my $count = 0;
      MOV:
        for (my $j = 0; $j <= $#ints; ++$j) {
            next MOV if $i == $j;
            ++$count if $ints[$i] < $ints[$j];
        }
        $seen{ $ints[$i] }++ if $count == $ints[$i];
    }
    return keys %seen;
}

my $input = "[2, 6, 1, 3]";

if (@ARGV) {
    $input = "@ARGV"
} else {
    print "default input: $input\n";
}

$input    =~ s{[][, ]+}{ }g;
$input    =~ s{\A\s+|\s+\Z}{};
my @L     = split m{ }, $input;

my @nobleInteger = nobleInt @L;

if ( @nobleInteger ){
    print "Noble integer: $nobleInteger[0]\n";
} else {
    print "No noble integer.\n";
}
