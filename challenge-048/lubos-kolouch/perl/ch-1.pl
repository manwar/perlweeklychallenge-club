#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/
#
#               Survivor
#
#               There are 50 people standing in a circle in position 1 to 50. The person standing at position 1 has a sword. He kills the next person i.e. standing at position 2 and pass on the sword to the immediate next i.e. person standing at position 3. Now the person at position 3 does the same and it goes on until only one survives.
#
#               Write a script to find out the survivor.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 02/21/2020 09:15:59 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

sub get_last_man_standing {
    my $count = shift;

    my %people;

    for ( 1 .. $count ) {
        $people{$_} = 1;
    }

    my $last   = 0;
    my $switch = 0;

    while (%people) {
        for my $key ( sort { $a <=> $b } keys %people ) {

            delete $people{$key} if $switch;

            $last   = $key;
            $switch = $switch == 0 ? 1 : 0;
        }
    }

    return $last;
}

my $people_count = $ARGV[0];

say get_last_man_standing($people_count);

# TESTS

use Test::More tests => 3;

is get_last_man_standing(50),37;
is get_last_man_standing(2),1;
is get_last_man_standing(3),3;

