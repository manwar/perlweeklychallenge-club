#!/usr/bin/env raku
sub group-digit-sum-gen ($int) {
    -> $str {
        $str.comb
        andthen .rotor: $int, :partial
        andthen .map: *.sum
        andthen [~] $_
    }
}

sub group-digit-sum ($str, $int) {
    $str, group-digit-sum-gen($int) ... *.chars ≤ $int
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is group-digit-sum(111122333,3), 359;
    is group-digit-sum(1222312,2), 76;
    is group-digit-sum(100012121001,4), 162;
    done-testing;
}

multi MAIN ($str, $int) {
    say group-digit-sum $str, $int
}
