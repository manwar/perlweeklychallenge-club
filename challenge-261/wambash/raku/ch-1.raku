#!/usr/bin/env raku

sub element-digit-sum (+@int) {
    @int.sum - [+] @int.map: |*.comb
}

multi MAIN (Bool :test($)!) {
    use Test;
    is element-digit-sum(1,2,3,45),36;
    is element-digit-sum(1,12,3),9;
    is element-digit-sum(1...4),0;
    is element-digit-sum(236, 416, 336, 350), 1296;
    done-testing;
}

multi MAIN (+ints) {
    say element-digit-sum ints
}
