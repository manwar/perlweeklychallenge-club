use strict;
use warnings;
use feature "say";

my $n = shift;
my $sum;
for my $num (1..$n) {
    $sum += $_ for split '', sprintf "%b", $num;
}
say $sum % 1000000007;
