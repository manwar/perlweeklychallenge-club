use strict;
use warnings;

use lib './lib';
use Fun;

my $fun = Fun->new;

print $fun->convert($ARGV[0]);
print "\n";

