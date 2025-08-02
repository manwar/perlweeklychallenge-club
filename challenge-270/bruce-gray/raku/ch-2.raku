sub task2 ( $level1cost, $level2cost, @ns is copy --> UInt ) {
    if ($level1cost, $level2cost).any < 0 {
        die "Negative cost is not explicitly forbidden by the task description, but I will not guarantee my algorithm is optimal if negative cost is allowed";
    }
    my $target = @ns.max;

    my $level_one_will_always_be_cheaper = ( $level2cost >= 2*$level1cost );
    if $level_one_will_always_be_cheaper {
        my @distances_to_maximum = $target X- @ns;
        return @distances_to_maximum.sum * $level1cost;
    }

    my $cost = 0;
    until @ns < 2 or @ns.all == $target {
        @ns .= sort(+*);
        pop @ns while @ns and @ns.tail == $target;
        if @ns >= 2 and @ns.head(2).all < $target {
            $cost += $level2cost;
            @ns[0]++;
            @ns[1]++;
        }
    }
    # Now either 0 or 1 elements of @ns can remain.
    if @ns {
        if @ns == 1 {
            $cost += ($level1cost * ($target - @ns.head) );
        }
        else {
            die "Cannot happen";
        }
    }

    return $cost;
}
use Test; plan +constant @tests =
    # $expected, $x, $y, @ints
    ( 9, 3, 2, (4, 1) ),
    ( 6, 2, 1, (2, 3, 3, 3, 5) ),
;
for @tests -> ($expected, $x, $y, @ns) {
    is task2($x, $y, @ns), $expected, "X($x) Y($y) INT(@ns[])";
}
