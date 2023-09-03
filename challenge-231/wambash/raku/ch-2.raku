#!/usr/bin/env raku
use experimental :pack;

sub unpack-passanger ($s) {
    $s
    andthen .encode: 'ascii'
    andthen .unpack: 'A10 A1 A2 A2'
    andthen  <phone sex age seat>  Z=> $_
    andthen .Map.Capture
}

sub senior-citizens (+list) {
    list
    andthen .map: &unpack-passanger
    andthen .grep: *.<age> ≥ 60
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is senior-citizens(<7868190130M7522 5303914400F9211 9273338290F4010>),  2;
    is senior-citizens(<1313579440F2036 2921522980M5644>), 0;
    done-testing;
}

multi MAIN (+list) {
    say senior-citizens list
}
