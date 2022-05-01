#! /usr/bin/env raku

subset ISBN where /^ <[0..9]>**3 "-" <[0..9]> "-" <[0..9]>**3 "-" <[0..9]>**5 "-" <[0..9]> $ /;

unit sub MAIN (ISBN $isbn13, :v(:$verbose));

my $digits = S:g/\-// given $isbn13;
my @digits = $digits.comb;
my $check  = @digits.pop;
my $r      = (10 - ( @digits[0, 2 ... *].sum * 2 + @digits.sum)) % 10;

say ": Source: $isbn13\n: Digits: $digits\n: Base:   { @digits.join }" if $verbose;

say ($r == $check)
  ?? "The Check Digit is correct"
  !! "The Check Digit is wrong (should have been $r)";
