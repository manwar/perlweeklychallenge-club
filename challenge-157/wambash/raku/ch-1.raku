#!/usr/bin/env raku

sub pythagorean-means (+@n) {
    @n
    andthen \(
        AM => .sum/.elems,
        GM => ([*] $_) ** (1 / .elems),
        HM => .elems / [+] (1 X/ $_),
    )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply pythagorean-means(1,3,5,6,9),\(AM => 24/5, GM => 810 ** (1/5), HM=> 5*90/ 163);
    is-deeply pythagorean-means(2,4,6,8,10),\(AM => 30/5, GM => (2*4*6*8*10)**(1/5), HM=> 5*120/137);
    is-deeply pythagorean-means(1,2,3,4,5), \(AM => 15/5, GM => 120 ** (1/5), HM=> 5*60/137);
    done-testing;
}

multi MAIN (*@n) {
    @n
    andthen .&pythagorean-means
    andthen .hash
    andthen .nodemap: *.fmt: '%0.1f'
    andthen .put
}
