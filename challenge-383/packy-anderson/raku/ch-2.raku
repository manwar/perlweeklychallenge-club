#!/usr/bin/env raku
use v6;

my @safe = (0, 51, 102, 153, 204, 255);

sub closest($num, @arr) {
  $num - @arr.map({ $num - $_ }).min({ $_.abs });
}

sub nearestRGB($color) {
  my $match = $color ~~ /\#(..)(..)(..)/; # grab the RGB values

  my @colors =
    $match.list                     # get the values 
    .map({ $_.Str.parse-base(16) }) # convert to decimal
    .map({ closest($_, @safe) });   # find closest web-safe value

  # convert back to hex and return as color code
  "#" ~ @colors.fmt('%02X', '');
}

sub solution($color) {
  say qq/Input: \$color = "$color"/;
  say qq/Output: "{nearestRGB($color)}"/;
}

say "Example 1:";
solution("#F4B2D1");

say "\nExample 2:";
solution("#15E6E5");

say "\nExample 3:";
solution("#191A65");

say "\nExample 4:";
solution("#2D5A1B");

say "\nExample 5:";
solution("#00FF66");
