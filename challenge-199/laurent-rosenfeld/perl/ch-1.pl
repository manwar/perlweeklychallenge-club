use strict;
use warnings;
use feature "say";

sub count_good_pairs {
    my @in = @_;
    my $count = 0;
    for my $i (0..$#in-1) {
        for my $j ($i+1..$#in) {
            $count++ if $in[$i] == $in[$j];
        }
    }
    return $count;
}

for my $test ( [1,2,3,1,1,3], [1,2,3], [1,1,1,1],
               [1,2,3,1,2,3], [4,3,2,3,2,1] ) {
    say sprintf "%-15s => %d", "@$test", count_good_pairs @$test;
}
