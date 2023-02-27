use strict;
use warnings;
use feature "say";

sub largest_xor {
    my $max = 0;
    my @max_ij;
    for my $i (0..$#_) {
        for my $j ($i+1.. $#_) {
            my $xor = $_[$i] ^ $_[$j];    # bitwise xor
            if ($xor > $max) {
                $max = $xor;
                @max_ij = ($_[$i], $_[$j]) ;
            }
        }
    }
    return "@max_ij -- $max";
}

for my $t ([1,2,3,4,5,6,7], [2,4,1,3], [10,5,7,12,8]) {
    printf "%-15s => %-10s \n", "@$t", largest_xor @$t;
}
