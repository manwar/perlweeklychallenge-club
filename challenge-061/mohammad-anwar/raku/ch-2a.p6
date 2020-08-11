#!/usr/bin/env perl6

use Test;

my Str @V = ipv4-partition("25525511135");

is @V.join(", "), "255.255.11.135, 255.255.111.35";

done-testing;

sub ipv4-partition(Str $ipv4_string) {

    my @valid = Empty;
    my $ipv4  = '';
    my $size  = $ipv4_string.chars;
    for 1 .. $size-3 -> $i {
        for $i+1 .. $size-2 -> $j {
            for $j+1 .. $size-1 -> $k {
                $ipv4 = $ipv4.substr(0, $k) ~ "." ~ $ipv4.substr($k)
                    if $ipv4.chars >= $k;
                $ipv4 = $ipv4.substr(0, $j) ~ "." ~ $ipv4.substr($j)
                    if $ipv4.chars >= $j;
                $ipv4 = $ipv4.substr(0, $i) ~ "." ~ $ipv4.substr($i)
                    if $ipv4.chars >= $i;

                @valid.push: $ipv4 if is-valid($ipv4);
                $ipv4 = $ipv4_string;
            }
        }
    }

    return @valid;
}

sub is-valid(Str $ipv4) {

    return False if $ipv4.chars == 0;

    for $ipv4.split(".") -> $octet {
        return False if ($octet.chars > 3)
                        ||
                        ($octet.Int > 255)
                        ||
                        ($octet.chars > 1 && $octet ~~ /^0/);
    }

    return True;
}
