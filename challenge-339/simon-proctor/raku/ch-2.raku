#!/usr/bin/env raku

subset IsTrue of Bool where so *;

multi sub MAIN( IsTrue :t(:$test) ) is hidden-from-USAGE {
    use Test;
    is peak-gain(-5, 1, 5, -9, 2),1;
    is peak-gain(10, 10, 10, -25),30;
    is peak-gain(3, -4, 2, 5, -6, 1), 6;
    is peak-gain(-1, -2, -3, -4), 0;
    is peak-gain(-10, 15, 5),10;
    done-testing;
}

multi sub MAIN( *@gains where Int() ~~ all(*) ) {
    peak-gain(|@gains).say;
}

sub peak-gain( *@ints where Int() ~~ all(*) ) {
    ([\+] (0, |@ints)).max;
}
