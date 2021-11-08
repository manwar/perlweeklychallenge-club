#!/usr/bin/env raku
sub ones-in-binary ($n) {
    $n.base(2).comb.sum
}

sub higher-integer-set-bits ( $n ) {
    (1,2,4 ...*)
    andthen .first: { $n !%% (2 * $_ ) }\
    andthen $n + $_
    andthen $_ + 2**(ones-in-binary($n)-  ones-in-binary($_)) - 1
}


multi MAIN (Bool :test($)!) {
    use Test;
    is higher-integer-set-bits(3),5;
    is higher-integer-set-bits(12),17;
    is higher-integer-set-bits(:2('101')),:2('110');
    is higher-integer-set-bits(:2('101_111')), :2('110_111');
    is higher-integer-set-bits(:2('11_111_111')),:2('101_111_111');
    done-testing;
}

multi MAIN ( $n ) {
    say higher-integer-set-bits $n
}
