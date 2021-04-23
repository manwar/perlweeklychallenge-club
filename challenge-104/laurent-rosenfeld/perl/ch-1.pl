use strict;
use warnings;
use feature "say";

my @fusc = (0, 1);
for my $i (2..49) {
    $fusc[$i] = $i % 2 == 0 ? $fusc[$i/2] :
        $fusc[($i-1)/2] + $fusc[($i+1)/2];
}
say join " ", @fusc;
