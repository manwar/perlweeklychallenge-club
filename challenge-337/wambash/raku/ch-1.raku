#!/usr/bin/env raku

sub smaller-than-current (+@num) {
    my %num-idx := (
        @num
        andthen .sort
        andthen .antipairs
        andthen .Map
    );

    %num-idx{@num}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is smaller-than-current(6,5,4,8), (2,1,0,3);
    is smaller-than-current(7 xx 4), (3 xx 4);
    is smaller-than-current(5...1), (4...0);
    is smaller-than-current(-1, 0, 3, -2, 1), (1,2,4,0,3);
    is smaller-than-current(0,1,1,2,0), (1,3,3,4,1);
    done-testing;
}

multi MAIN (+num) {
    put smaller-than-current num;
}
