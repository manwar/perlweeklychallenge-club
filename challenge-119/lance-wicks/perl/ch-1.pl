use strict;
use warnings;

use lib './lib';
use Nibble;
my $nibble = Nibble->new;

my $n   = $ARGV[0];
my $res = $nibble->swap($n);

print "Input \$N = $n\n";
print "Output: $res\n";

