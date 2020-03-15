#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/         #
#                                                                         #
# Merge Intervals                                                         #
# Write a script to merge the given intervals where ever possible.        #
#                                                                         #
# [2,7], [3,9], [10,12], [15,19], [18,22]                                 #
#                                                                         #
# The script should merge [2, 7] and [3, 9] together to return [2, 9].    #
#                                                                         #
# Similarly it should also merge [15, 19] and [18, 22] together to        #
# return [15, 22].                                                        #
#                                                                         #
# The final result should be something like below:                        #
#                                                                         #
# [2, 9], [10, 12], [15, 22]                                              #
#                                                                         #
###########################################################################

use strict;
use warnings;
use List::MoreUtils qw( minmax );

my $input = "[2,7], [3,9], [10,12], [15,19], [18,22]";

$input = "@ARGV" if @ARGV;

$input =~ s{[][, ]+}{ }g;
$input =~ s{\A\s+|\s+\Z}{};

my @sets = split m{ }, $input;

sub printSets {
    for (my $i=0; $i < $#_; $i += 2) {
        print "[$_[$i], $_[$i+1]]";
        print ", " if $i+1 < $#_;
    }
    print "\n";
}

sub mergeUnits {
    my @indicies = @_;
    my ($min, $max) = minmax ( $sets[$indicies[0]], $sets[$indicies[1]], $sets[$indicies[2]], $sets[$indicies[3]] );
    push @sets, $min;
    push @sets, $max;

    foreach ( sort { $b <=> $a } @indicies ) {
        splice @sets, $_, 1;
    }
}

print "UNMERGED:\n";
printSets @sets;

OUTER:
for (my $j=0; $j < $#sets; $j += 2) {
    for ( my $k=$j+2; $k < $#sets; $k += 2) {

        if ( $sets[$k] >= $sets[$j] and $sets[$k] <= $sets[$j+1]
                     or $sets[$k+1] >= $sets[$j] and $sets[$k+1] <= $sets[$j+1] ) {

            mergeUnits $j, $j+1, $k, $k+1;
            $j = -2;            # This resets OUTER loop to 0 after its double increment
            next OUTER;
        }
    }
}

@sets = sort { $a <=> $b } @sets;
print "\nMERGED:\n";
printSets @sets;
