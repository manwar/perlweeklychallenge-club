use strict;
use warnings;
use feature "say";

sub is_monotonic {
    my @in = @_;
    my ($ascending, $descending) = (1, 1);
    for my $i (1..$#in) {
        $ascending  = 0 if $in[$i] < $in[$i-1];
        $descending = 0 if $in[$i] > $in[$i-1]
    }
    return $ascending || $descending;
}
for my $test ([<1 2 2 3>], [<1 3 2>], [<6 5 5 4>]) {
    printf "%-10s => %d\n", "@$test", is_monotonic @$test;
}
