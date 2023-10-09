use strict;
use warnings;

use lib './lib';
use RunningSum;

use Data::Dumper qw(Dumper);
 

my $out = RunningSum->run(@ARGV);


print "Input: ";
print join(", ", @ARGV);
print "\n";

print "Output: ";
print join(", ", @{$out});
print "\n";