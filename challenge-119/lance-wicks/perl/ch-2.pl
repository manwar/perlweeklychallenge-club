use strict;
use warnings;

use lib './lib';
use Sequence;
my $seq = Sequence->new;

my $n   = $ARGV[0];
my $res = $seq->no_one_on_one($n);

print "Input \$N = $n\n";
print "Output: $res\n";

