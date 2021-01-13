#!/usr/bin/env raku

multi count-set-bit ($n) {
    1 .. $n
    andthen .map: |*.polymod(2 xx *)
    andthen .sum
}

multi count-set-bit ($n where * ≥ 100) {
    count-set-bit-big( $n )
}

constant $mod=1000000007;
sub count-set-bit-big ($n) {
    $n
    andthen .polymod(2 xx *)
    andthen .grep: * == 1, :k
    andthen .reverse
    andthen .map: { ( ( ($_ + 2*$++) mod $mod)  *  2.expmod($_-1 ,$mod) + 1 ) mod $mod }\
    andthen .sum mod $mod
}

multi MAIN (:$test!) {
    use Test;
    is count-set-bit(3), 4;
    is count-set-bit(4), 5;
    is count-set-bit-big(3), 4;
    is count-set-bit-big(4), 5;
    is count-set-bit-big($_), count-set-bit($_), "$_" for ^100 .pick(10);
    is count-set-bit(10_000), 64613;
    is count-set-bit(3**2**12), 562270664;
    done-testing;
}
