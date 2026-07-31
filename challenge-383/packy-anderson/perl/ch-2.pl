#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( min_by );

my @safe = (0, 51, 102, 153, 204, 255);

sub closest($num, @arr) {
  $num - min_by { abs($_) } map { $num - $_ } @arr;
}

sub nearestRGB($color) {
  sprintf "#%02X%02X%02X",      # convert back to hex and
                                # return as color code
    map { closest($_, @safe) }  # find closest web-safe value
    map { hex($_) }             # convert to decimal
    unpack("x1A2A2A2", $color); # grab the RGB values  
}

sub solution($color) {
  say qq/Input: \$color = "$color"/;
  say qq/Output: "@{[ nearestRGB($color) ]}"/;
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
