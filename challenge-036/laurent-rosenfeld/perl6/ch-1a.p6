use v6;
use Test;

sub validate ($vin) {
    return False if $vin ~~ /<[OIQ]>/;
    return True if $vin ~~ /^ <[A..Z0..9]> ** 17 $/;
    return False;
}

plan 16;

ok  validate("A" x 17),   "17 A's";
ok  validate(1 x 17),     "17 digits";
nok validate("AEIOU"),    "Five vowels";
nok validate(1234567890), "Ten digits";
nok validate("1234AEIOU5678901"),   "sixteen digits or letters";
ok  validate("12345678901234567"),  "17 digits";
nok validate("1234567890123456Q"),  "16 digits and a Q";
nok validate("1234567890123456O"),  "16 digits and a O";
nok validate("1234567890123456I"),  "16 digits and a I";
nok validate("Q1234567890123456"),  "A Q and 16 digits";
nok validate("I1234567890123456"),  "An I and 16 digits";
ok  validate("ABCD4567890123456"),  "17 digits and letters";
nok validate("ABef4567890123456"),  "Digits and some lower case letters";
nok validate("ABE?4567890123456"),  "A non alphanumerical character";
nok validate("ABCD4567 90123456"),  "A space";
nok validate("ABCD45678901234567"), "More than 17 characters";
