use strict;
use warnings;
use feature "say";

my $input = $ARGV[0] // 248832;
for my $i (1..10) {
    printf "%2i\t%10.3f\n", $i, $input ** (1/$i);
}
