#!/usr/bin/env raku

sub decode-xor (+encoded, :$initial=1) {
   [\+^] $initial, |encoded
}

multi MAIN (Bool :test($)!) {
    use Test;
    is decode-xor(1,2,3), (1,0,2,1);
    is decode-xor(6,2,7,3):4initial, (4,2,0,7,4);
    done-testing;
}

multi MAIN (+encoded) {
    put decode-xor encoded
}
