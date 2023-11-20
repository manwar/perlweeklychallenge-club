use strict;
use warnings;
use feature 'say';

sub floor_sum {
    my @in = @_;
    my $end = $#in;
    my $count = 0;
    for my $i (0..$end) {
        for my $j (0..$end) {
            $count += int($in[$i] / $in[$j]) ;
        }
    }
    return $count;
}

for my $test ([<2 5 9>], [<4 9 3 2>], [<7 7 7 7 7 7 7>]) {
    printf "%-15s => ", "@$test";
    say floor_sum @$test;
}
