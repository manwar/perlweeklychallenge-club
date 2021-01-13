#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/         #
#                                                                         #
# Survivor                                                                #
# There are 50 people standing in a circle in position 1 to 50.           #
# The person standing at position 1 has a sword. He kills the next person #
# i.e. standing at position 2 and pass on the sword to the immediate next #
# i.e. person standing at position 3. Now the person at position 3 does   #
# the same and it goes on until only one survives.                        #
#                                                                         #
#   Write a script to find out the survivor.                              #
#                                                                         #
#                                                                         #
###########################################################################

use strict;
use warnings;
use Getopt::Long;

GetOptions(\my %option, 'verbose|v') or die "Bad options\n";

# -v or --verbose for detailed output.

my @circle = ( 1 .. 50 );

for (my $i = 1; scalar @circle > 1 ; ++$i) {

    print "i: $i\n" if $option{verbose};
    
    my $victim = splice(@circle, $i, 1);
    
    if ($option{verbose}) {
        
        print $circle[$i-1] . " killed " . $victim . "\n";
        print "@circle\n\n";

    }

    # When the end of the array is reached,
    # roll back the index to go back around the circle for another iteration.
    # In odd cases the next victim will be 0. In even cases it will be 1.
    # These have to be adjusted due to the for loop's incrementing: -1 for odd, 0 for even.
    
    if ( $#circle - $i == 0) {

        $i = -1;

    } elsif ( $#circle - $i == -1) {

        $i = 0;

    }
}

print "@circle survives\n";

__END__
output:

37 survives
