# You are given a set of coins @C, assuming you have infinite amount of each
# coin in the set.
#
# Write a script to find how many ways you make sum $S using the coins from the
# set @C.
# Example:
#
# Input:
#     @C = (1, 2, 4)
#     $S = 6
#
# Output: 6
# There are 6 possible ways to make sum 6.
# a) (1, 1, 1, 1, 1, 1)
# b) (1, 1, 1, 1, 2)
# c) (1, 1, 2, 2)
# d) (1, 1, 4)
# e) (2, 2, 2)
# f) (2, 4)

sub coins-sum(@C, $S) {
    if ($S == 0) {
        return [(),];
    }

    my @ret = [];
    for @C -> $c {
        if ($c <= $S) {
            for coins-sum(@C, $S - $c) -> @r {
                if ($c <= @r.min) {
                    @ret.push([$c, |(@r)]);
                }
            }
        }
    }
    return @ret;
}

coins-sum((1, 2, 4), 6).say;
