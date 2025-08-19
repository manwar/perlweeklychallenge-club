#!/usr/bin/env raku

sub range-sum (+ints,:$x,:$y) {
    sum ints[$x..$y]

}

multi MAIN (Bool :test($)!) {
    use Test;
    is range-sum(-2, 0, 3, -5, 2, -1):0x:2y, 1;
    is range-sum(1, -2, 3, -4, 5):1x:3y, -3;
    is range-sum(1, 0, 2, -1, 3):3x:4y, 2;
    is range-sum(-5, 4, -3, 2, -1, 0):0x:3y, -2;
    is range-sum(-1, 0, 2, -3, -2, 1):0x:2y, 1;
    done-testing;
}

 multi MAIN (+ints,:$x,:$y) {
     say range-sum ints,:$x,:$y;
}
