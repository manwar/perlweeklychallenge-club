#!/usr/bin/perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/         #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;

my @doors = ();
my $MAX = 500;

sub change {
    return $_[0] eq "OPENED" ? "CLOSED" : "OPENED";
}

push @doors, "CLOSED" foreach (0..$MAX);

ROOM:
for ( my $i = 1; $i <= $MAX; ++$i ) {

    if ($i > $MAX / 2 ) { 
       $doors[$i] =  change $doors[$i];
       next ROOM;
   }

   for ( my $j = 1; $j <= $MAX; ++$j ) {
       if ($j % $i == 0) {
           $doors[$j] =  change $doors[$j];
       }
   }
}

for ( my $k = 1; $k <= $MAX; ++$k ) { 
    print "$k " if $doors[$k] eq "OPENED";
}
print "\n";

__END__
ch-2.pl output:

1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484 
