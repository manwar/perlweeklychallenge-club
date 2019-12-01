#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Test::More tests => 16;

sub validate {
    my $vin = shift;
    return 0 if $vin =~ /[OIQ]/;
    return 1 if $vin =~ /^[A-Z0-9]{17}$/;
    return 0;
}

ok validate("A" x 17),  "17 A's";
ok validate(1 x 17)  ,  "17 digits";
is validate("AEIOU")   , 0, "Five vowels";
is validate(1234567890), 0, "Ten digits";
is validate("1234AEIOU5678901"),   0, "Sixteen digits or letters";
is validate("12345678901234567"),  1, "17 digits";
is validate("1234567890123456Q"),  0, "16 digits and a Q";
is validate("1234567890123456O"),  0, "16 digits and a O";
is validate("1234567890123456I"),  0, "16 digits and a I";
is validate("Q1234567890123456"),  0, "A Q and 16 digits";
is validate("I1234567890123456"),  0, "An I and 16 digits";
is validate("ABCD4567890123456"),  1, "17 digits and letters";
is validate("ABef4567890123456"),  0, "Digits and some lower case letters";
is validate("ABE?4567890123456"),  0, "A non alphanumerical character";
is validate("ABCD4567 90123456"),  0, "A space";
is validate("ABCD45678901234567"), 0, "More than 17 characters";
