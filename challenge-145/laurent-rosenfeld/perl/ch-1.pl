use strict;
use warnings;
use feature "say";

my @a = (1, 2, 3);
my @b = (4, 5, 6);

my $result = 0;
$result += $_ for map { $a[$_] * $b[$_] } 0..$#a;
say $result;
