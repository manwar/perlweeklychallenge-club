use warnings;
use strict;

my @men = 1 .. 50; 
while ( @men > 1 ) { push @men, my ($d,) = splice @men, 0, 2 }
print "Survivor: @men";