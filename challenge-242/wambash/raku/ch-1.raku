#!/usr/bin/env raku

sub missing-members (@arr1,@arr2) {
    @arr1 ∖ @arr2, @arr2 ∖ @arr1
    andthen .map: *.keys.sort.list
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply missing-members((1,2,3),(2,4,6)),((1,3),(4,6));
    is-deeply missing-members((1,2,3,3),(1,1,2,2)),((3,),());
    done-testing;
}

multi MAIN (:@arr1,:@arr2) {
    say missing-members @arr1,@arr2
}
