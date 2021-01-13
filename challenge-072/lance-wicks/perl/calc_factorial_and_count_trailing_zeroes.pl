use strict;
use warnings;

use lib './lib';
use Trailing::Zeroes;

my $N = $ARGV[0];

my $fz = Trailing::Zeroes->new;

print "\n";
print $fz->count($fz->factorial($N));
print "\n";
