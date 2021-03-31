use strict;
use warnings;

use lib './lib';
use Maxgap;

my $maxgap = Maxgap::maxgap(@ARGV);

print "Output: $maxgap\n";
