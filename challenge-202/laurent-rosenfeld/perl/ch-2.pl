use strict;
use warnings;
use feature "say";

sub widest_valley {
    my (@valley, @temp);
    for my $i (1..$#_) {     # valley with no left part
        push @valley, $_[$i-1];
        last if $_[$i] < $_[$i-1];
    }

    for my $i (1..$#_) {
        my $left = 1;
        for my $j ($i..$#_) {
            if ($left) {
                push @temp, $_[$j - 1];
                push @temp, $_[$j] and $left = 0
                    if $_[$j] > $_[$j - 1];
            } else {
                last if $_[$j] < $_[$j-1];
                push @temp, $_[$j];
            }
        }
        @valley = @temp if scalar @temp > scalar @valley;
        @temp = ();
    }
    return @valley;
}

for my $test ([<1 5 5 2 8>], [<1 5 5 2>], [<2 6 8 5>],
    [<9 8 13 13 2 2 15 17>], [<2 1 2 1 3>],
    [<1 3 3 2 1 2 3 3 2>]) {
        printf "%-20s  => ", join " ", @$test;
        say join " ", widest_valley @$test;
}
