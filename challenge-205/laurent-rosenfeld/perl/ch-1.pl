use strict;
use warnings;
use feature "say";


sub third_largest  {
    my @s = sort {$b <=> $a} @_;
    return scalar @s >= 3 ? $s[2] : $s[0];
}
for my $t ([<5 3 4>], [<5 6>], [<5 4 4 3>],
           [<5 6 7 8 2 1>]) {
    printf "%-12s => %d \n", "@$t", third_largest @$t;
}
