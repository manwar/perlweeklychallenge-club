use strict;
use warnings;

use Test::More tests => 1;
use lib '.';
require '5702.pm';

my $in = [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ];
my $want = [ "alph", "b", "car", "cadm", "cade", "alpi" ];

is_deeply shortest_prefs ($in), $want;
