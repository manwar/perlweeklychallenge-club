#!/usr/bin/env raku

sub skip-or-rotate (@a) {
    @a.head == @a.min ?? @a.skip !! @a.rotate
}

sub empty-array (+int) {
    elems int, &skip-or-rotate ...^ :!elems

}

multi MAIN (Bool :test($)!) {
    use Test;
    is skip-or-rotate((3,4,2)), (4,2,3);
    is skip-or-rotate((1,2,3)), (2,3);
    is empty-array(3,4,2), 5;
    is empty-array(1,2,3), 3;
    done-testing;
}

multi MAIN (+int) {
    say empty-array int
}
