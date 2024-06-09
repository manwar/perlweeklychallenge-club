#!/usr/bin/env raku

use v6.d;

sub defang-IP-address(Str $ip --> Str) {
    $ip.subst(".", "[.]", :g)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is defang-IP-address("1.1.1.1"), "1[.]1[.]1[.]1",
        'works for 1.1.1.1';
    is defang-IP-address("255.101.1.0"), "255[.]101[.]1[.]0",
        'works for 255.101.1.0';
}

#| Take user provided ip like 1.1.1.1
multi sub MAIN(Str $ip) {
    say defang-IP-address($ip);
}
