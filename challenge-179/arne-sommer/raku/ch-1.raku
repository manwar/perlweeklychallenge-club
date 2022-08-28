#! /usr/bin/env raku

unit sub MAIN (UInt $integer);

my %mapping =
(
    0  => "zeroth",
    1  => "first",
    2  => "second",
    3  => "third",
    4  => "fourth",
    5  => "fifth",
    6  => "sixth",
    7  => "seventh",
    8  => "eighth",
    9  => "ninth",
   10  => "tenth",
   11  => "eleventh",
   12  => "twelfth",
   13  => "thirteenth",
   14  => "fourteenth",
   15  => "fifteenth",
   16  => "sixteenth",
   17  => "seventeenth",
   18  => "eighteenth",
   19  => "nineteenth",
   20  => "twenty",
  '2x' => "twentieth",
   30  => "thirty",
  '3x' => "thirtieth",
   40  => "forty",
  '4x' => "fortieth",
   50  => "fifty",
  '5x' => "fiftieth",
   60  => "sixty",
  '6x' => "sixtieth",
   70  => "seventieth",
  '7x' => "seventy",
   80  => "eightieth",
  '8x' => "eighty",
   90  => "ninetieth",
  '9x' => "ninety",
  100  => "hundreth",
  1000 => "thousandth",
);

if %mapping{$integer}
{
  say %mapping{$integer};
}
else
{
  die "Unsupported value. Use 0-100,1000 only" if $integer.chars > 2;
  my ($first, $second) = $integer.comb;

  say "{ %mapping{$first ~ "x"} }-{ %mapping{$second} }";
}
