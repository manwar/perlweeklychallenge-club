#!/usr/bin/env raku
sub affix (+a) {
    my $roots := a.Bag;
    $roots
    andthen .keys
    andthen .sort
    andthen .grep: * !== 0
    andthen .map: { $_, $roots ∖ $_ }
}

sub root (($a,$adepts)) {
    $adepts
    andthen .keys
    andthen .sort
    andthen .map: { $a ~ $_, $adepts ∖ $_ }\
    andthen .Slip
}

sub suffix (($ar,$adepts)) {
    $adepts
    andthen .keys
    andthen .sort
    andthen .grep: * %% 2
    andthen .map: { $ar ~ $_ }\
    andthen .Slip
}

sub three-digits-even (+ints) {
    ints
    andthen .&affix
    andthen .map: &root
    andthen .map: &suffix
}



multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply affix(2, 1, 1, 0), ( (1, bag(2,1,0)), (2,bag(1,1,0)) );
    is-deeply root((1, bag(2,1))), slip(('11',bag(2)), ('12',bag(1)));
    is suffix(('21',bag(1,0,2))), <210 212>;
    is three-digits-even(2, 1, 3, 0), (102, 120, 130, 132, 210, 230, 302, 310, 312, 320);
    is three-digits-even(2, 2, 8, 8, 2), (222, 228, 282, 288, 822, 828, 882);
    done-testing;
}

multi MAIN (+ints) {
    put three-digits-even ints
}
