use strict;
use warnings;
use feature "say";

sub find_quadruplets {
    my $count = 0;
    my $last = $#_;
    for my $i (0..$last-3) {
        for my $j ($i+1..$last-2) {
            for my $k ($j+1..$last-1) {
                my $target = $_[$i] + $_[$j] + $_[$k];
                $count += grep { $_ == $target }
                    @_[$k+1..$last];

            }
        }
    }
    return $count;
}

for my $test ([<1 2 3 6>], [<1 1 1 3 5>], [<1 1 1 3 5 5>],
    [<3 3 6 4 5>], [<3 3 6 12 21>], [<1 1 1 3 5 9>]) {
    printf "%-15s -> %d\n", "@$test", find_quadruplets @$test;
}
