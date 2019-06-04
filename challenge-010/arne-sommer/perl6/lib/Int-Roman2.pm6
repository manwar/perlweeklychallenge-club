use v6.c;

unit module Int-Roman2;

use MONKEY-TYPING;

augment class Int
{
  method roman
  {
    my $value = self;
    my $string = "";

    while $value >= 1000 { $string ~= "M";  $value -= 1000; }
    if $value >= 900     { $string ~= "CM"; $value -= 900; }
    if $value >= 500     { $string ~= "D";  $value -= 500; }
    if $value >= 400     { $string ~= "CD"; $value -= 400; }
    while $value >= 100  { $string ~= "C";  $value -= 100; }
    if $value >= 90      { $string ~= "XC"; $value -= 90; }
    if $value >= 50      { $string ~= "L";  $value -= 50; }
    if $value >= 40      { $string ~= "XL"; $value -= 40; }
    while $value >= 10   { $string ~= "X";  $value -= 10; }
    if $value >= 9       { $string ~= "IX"; $value -= 9; }
    if $value >= 5       { $string ~= "V";  $value -= 5; }
    if $value >= 4       { $string ~= "IV"; $value -= 4; }
    while $value >= 1    { $string ~= "I";  $value -= 1; }

    return $string;
  }

  multi method base ("r")
  {
    return self.roman;
  }
}


