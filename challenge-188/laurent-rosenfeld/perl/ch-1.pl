use strict;
use warnings;
use feature qw/say/;

for my $test ([2, [<4 5 1 6>]], [2, [<1 2 3 4>]],
    [3, [<1 3 4 5>]], [4, [<5 1 2 3>]],
    [4, [<7 2 4 5>]], [2, [< 1 2 3 4 5 6 7 >]]) {
    my $k = $test->[0];
    my @list = @{$test->[1]};
    my $count = 0;
    for my $i (0..$#list) {
        for my $j (($i+1) .. $#list) {
            ++$count if ($list[$i] + $list[$j]) % $k == 0;
        }
    }
    say "$k  (@list)  -> ", $count;
}
