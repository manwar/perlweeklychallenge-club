#!/usr/bin/env raku

sub middle-index (+ints) {
    my @sum  = [\+] |ints;
    my @rsum = reverse [\+] |ints.reverse;

    @sum Z== @rsum
    andthen .first: *.so, :k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is middle-index(2,3,-1,8,4),3;
    is middle-index(1,-1,4),2;
    is middle-index(2,5),Nil;
    done-testing;
}

multi MAIN (+ints) {
    say middle-index(ints)//-1
}
