#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a 6-digit hex color.

Write a script to round the RGB channels to the nearest web-safe value and return the nearest RGB color.

    00 (0), 33 (51), 66 (102), 99 (153), CC (204) and FF (255)

Example 1

Input: $color = "#F4B2D1"
Output: "#FF99CC"

Red: F4 (Decimal 244), closer to 255 => FF
Green: B2 (Decimal 178), closer to 153 => 99
Blue: D1 (Decimal 209), closer to 204 => CC
So the nearest RGB: "#FF99CC"

Example 2

Input: $color = "#15E6E5"
Output: "#00FFCC"

Red: 15 (Decimal 21), closer to 0 => 00
Green: E6 (Decimal 230), closer to 255 => FF
Blue: E5 (Decimal 229), closer to 204 => CC

Example 3

Input: $color = "#191A65"
Output: "#003366"

Red: 19 (Decimal 25), closer to 0 => 00
Green: 1A (Decimal 26), closer to 51 => 33
Blue: 65 (Decimal 101), closer to 102 => 66

Example 4

Input: $color = "#2D5A1B"
Output: "#336633"

Red: 2D (Decimal 45), closer to 51 => 33
Green: 5A (Decimal 90), closer to 102 => 66
Blue: 1B (Decimal 27), closer to 51 => 33

Example 5

Input: $color = "#00FF66"
Output: "#00FF66"

Red: 00 (Decimal 0), closer to 0 => 00
Green: FF (Decimal 255), closer to 255 => FF
Blue: 66 (Decimal 102), closer to 102 => 66
=cut

use List::Util qw(first);

# Calculate 255 numbers in advance and save it somethere.
my %WEB_SAFE = map { $_ => undef } (0, 51, 102, 153, 204, 255);
my %ALL_COL;
my @ALL_NUM = 0 .. 255;

for my $num ( @ALL_NUM )
{
     $ALL_COL{$num} = first { abs($_ - $num) <= 25 } keys %WEB_SAFE; 
}

use Test2::V0 -no_srand => 1;

is(nearest_RGB('#F4B2D1'), '#FF99CC', 'Example 1');
is(nearest_RGB('#15E6E5'), '#00FFCC', 'Example 2');
is(nearest_RGB('#191A65'), '#003366', 'Example 3');

is(nearest_RGB('#2D5A1B'), '#336633', 'Example 4');
is(nearest_RGB('#00FF66'), '#00FF66', 'Example 5');

done_testing();



sub nearest_RGB
{
     my $color = $_[0];
     my @rgb = 
          map { sprintf("%02X", $ALL_COL{hex($_)}) }
          unpack("xA2A2A2", $color);
     return join('', '#', @rgb);;
}
