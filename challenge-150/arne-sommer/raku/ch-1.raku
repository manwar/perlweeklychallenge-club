#! /usr/bin/env raku

subset DigitStr where * ~~ /^<[0..9]>+$/;

unit sub MAIN (DigitStr $a, DigitStr $b);

for ($a, $b, * ~ * ... *) -> $current
{
  if $current.chars >= 51
  {
    say $current.substr(50, 1);
    last;
  }
}
