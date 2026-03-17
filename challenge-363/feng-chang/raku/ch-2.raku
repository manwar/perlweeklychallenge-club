#!/bin/env raku

unit sub MAIN(Str:D $ip, Str:D $subnet);

my regex ipv4-octet  { \d+ <?{ 0 ≤ $/.Int ≤ 255 }> }
my regex ipv4        { <ipv4-octet> ** 4 % '.' }
my regex ipv4-subnet { <ipv4> '/' $<len> = \d+ <?{ 0 ≤ $<len>.Int ≤ 32 }> }

sub ip-match(Str:D $ip, Str:D $subnet --> Bool:D) {
    if $ip ~~ /^ <ipv4> $/ {
        my ($ip-num, $subnet-num);

        my @n = $ip.comb(/\d+/);
        $ip-num = @n[0] * 256**3 + @n[1] * 256**2 + @n[2] * 256 + @n[3];

        if $subnet ~~ /^ <ipv4-subnet> $/ {
            my @n = $subnet.comb(/\d+/);
            $subnet-num = @n[0] * 256**3 + @n[1] * 256**2 + @n[2] * 256 + @n[3];

            return $ip-num.base(2).substr(0, @n[4]) eq $subnet-num.base(2).substr(0, @n[4]);
        }
    }

    False
}

put so $ip ~~ /^<ipv4>$/ && $subnet ~~ /^<ipv4-subnet>$/ && ip-match($ip, $subnet);
