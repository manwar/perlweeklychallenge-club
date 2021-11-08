use strict;
use warnings;
use feature qw/say/;

my $n = shift // 24;
my $count = scalar grep {not /1/} 2..$n;
say "There are $count integers with no 1 in the 1..$n range";
