#!/usr/bin/env raku

sub left-right-sum-diff (+$_) {
    zip(
        ([\+] 0, |.skip.reverse).reverse,
        ([\+] 0, |$_),
        with => { abs $^a - $^b }
    )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is left-right-sum-diff(10,4,8,3), (15,1,11,22);
    is left-right-sum-diff(1), (0);
    is left-right-sum-diff(1..5), (14,11,6,1,10);
    done-testing;
}

multi MAIN (+ints) {
    say left-right-sum-diff ints
}
