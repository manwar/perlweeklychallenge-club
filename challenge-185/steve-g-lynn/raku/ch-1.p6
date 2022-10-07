#!/usr/bin/env perl6

say &mac('1ac2.34f0.b1c2');
say &mac('abc1.20f1.345a'); 

sub mac ($mac) {    
    my @mac;    
    for ($mac.split('.')) -> $mac_ {
        @mac.append(substr($mac_,0,2), substr($mac_,2,2));   
    }
    return @mac.join(':');
}

