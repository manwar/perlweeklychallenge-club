#!/usr/bin/env raku

sub defang-IP-address ($ip) {
    $ip.trans: ['.'] => ['[.]']
}

multi MAIN (Bool :test($)!) {
    use Test;
    is defang-IP-address('1.1.1.1'),'1[.]1[.]1[.]1';
    is defang-IP-address('255.101.1.0'),'255[.]101[.]1[.]0';
    done-testing;
}

multi MAIN ($ip) {
    say defang-IP-address $ip
}
