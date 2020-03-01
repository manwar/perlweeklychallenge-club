#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/         #
#                                                                         #
# Palindrome Dates                                                        #
# Write a script to print all Palindrome Dates between 2000 and 2999.     #
# The format of date is mmddyyyy. For example, the first one was on       #
# October 2, 2001 as it is represented as 10022001.                       #
#                                                                         #
###########################################################################

use strict;
use warnings;

#  M   M   D   D  Y   Y   Y   Y
# [01][*][012][2][2][012][*][01]
#  $k $j  $i         $i  $j  $k
#
# $k - Months can only begin with 0 or 1.
# $j - The second months digit needs all numbers e.g. January 01 to October 10 (and of course beyond).
# $i - Days begin with 0,1,2,3, However all years begin with 2 so the cooresponding number
# means all days end in 2. 32 is not a valid day so the 3 is not needed.

for ( my $i=0; $i < 3; ++$i ){

    for ( my $j=0; $j < 10; ++$j ){

      EDGES:
        for ( my $k=0; $k < 2; ++$k ){

            if (( $k == 1 and $j > 2 ) or ( $k == 0 and $j == 0 )) { # Months cannot be > 12 or 00
                next EDGES;
            }
            print "$k$j-${i}2-2$i$j$k\n";
        }
    }
}

__END__
output:

10-02-2001
01-02-2010
11-02-2011
02-02-2020
12-02-2021
03-02-2030
04-02-2040
05-02-2050
06-02-2060
07-02-2070
08-02-2080
09-02-2090
10-12-2101
01-12-2110
11-12-2111
02-12-2120
12-12-2121
03-12-2130
04-12-2140
05-12-2150
06-12-2160
07-12-2170
08-12-2180
09-12-2190
10-22-2201
01-22-2210
11-22-2211
02-22-2220
12-22-2221
03-22-2230
04-22-2240
05-22-2250
06-22-2260
07-22-2270
08-22-2280
09-22-2290
