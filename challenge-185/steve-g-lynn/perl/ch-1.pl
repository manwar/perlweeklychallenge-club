#!/usr/bin/env perl

print &mac('1ac2.34f0.b1c2'),"\n";
print &mac('abc1.20f1.345a'),"\n"; 

sub mac {
    my ($mac)=shift;    
    my @mac;    
    foreach (split(/\./,$mac)) {
        push @mac, (substr($_,0,2), substr($_,2,2));   
    }
    return join(':',@mac);
}

