# Write a script that finds the first square number that has at 
# least 5 distinct digits. This was proposed by Laurent Rosenfeld.

use strict;
use warnings;
use 5.010;

my $start_run = time();

#316 came from sqrt of 99999 => 316.22 so this solution assumes that the number
#we are looking for can be found between 10000 to 99999
for (100..316) {
    my %h;
    @h{$_**2 =~ /./g} = 1;
    (5 == ~~keys %h) && (say "First square number that has at least 5 distinct: ".$_*$_) && last
}

my $run_time  = time() - $start_run;
say "Run Time: $run_time sec";