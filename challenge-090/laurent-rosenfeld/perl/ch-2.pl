use strict;
use warnings;
use feature "say";

my ($c, $d) = @ARGV;
my $result = $c % 2 ? $d : 0;
while ($c > 1) {
    $c = $c >> 1; # right shift 1 bit = div by 2
    $d *= 2;
    $result += $d if $c % 2;
}
say $result;
