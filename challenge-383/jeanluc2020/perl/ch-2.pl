#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-383/#TASK2
#
# Task 2: Nearest RGB
# ===================
#
# You are given a 6-digit hex color.
#
# Write a script to round the RGB channels to the nearest web-safe value and
# return the nearest RGB color.
#
### 00 (0), 33 (51), 66 (102), 99 (153), CC (204) and FF (255)
#
## Example 1
##
## Input: $color = "#F4B2D1"
## Output: "#FF99CC"
##
## Red: F4 (Decimal 244), closer to 255 => FF
## Green: B2 (Decimal 178), closer to 153 => 99
## Blue: D1 (Decimal 209), closer to 204 => CC
## So the nearest RGB: "#FF99CC"
#
## Example 2
##
## Input: $color = "#15E6E5"
## Output: "#00FFCC"
##
## Red: 15 (Decimal 21), closer to 0 => 00
## Green: E6 (Decimal 230), closer to 255 => FF
## Blue: E5 (Decimal 229), closer to 204 => CC
#
## Example 3
##
## Input: $color = "#191A65"
## Output: "#003366"
##
## Red: 19 (Decimal 25), closer to 0 => 00
## Green: 1A (Decimal 26), closer to 51 => 33
## Blue: 65 (Decimal 101), closer to 102 => 66
#
## Example 4
##
## Input: $color = "#2D5A1B"
## Output: "#336633"
##
## Red: 2D (Decimal 45), closer to 51 => 33
## Green: 5A (Decimal 90), closer to 102 => 66
## Blue: 1B (Decimal 27), closer to 51 => 33
#
## Example 5
##
## Input: $color = "#00FF66"
## Output: "#00FF66"
##
## Red: 00 (Decimal 0), closer to 0 => 00
## Green: FF (Decimal 255), closer to 255 => FF
## Blue: 66 (Decimal 102), closer to 102 => 66
#
############################################################
##
## discussion
##
############################################################
#
# We split the string into the hex value pairs for R, G and B.
# Then we turn those values into their decimal values. Now we
# just need to find the closest number in our web-friendly map.
# We then put together the found values and are done.

use v5.36;


### 00 (0), 33 (51), 66 (102), 99 (153), CC (204) and FF (255)
sub nearest_rgb($color) {
    say "Input: \"$color\"";
    my $map = {
        0   => "00", 51  => "33", 102 => "66",
        153 => "99", 204 => "CC", 255 => "FF"
    };
    my $r = hex(substr($color, 1, 2));
    my $g = hex(substr($color, 3, 2));
    my $b = hex(substr($color, 5, 2));
    my $result = "#";
    foreach my $color (($r, $g, $b)) {
        if($color <= 25) { # 25 is closer to 0, 26 to 51
            $result .= $map->{0};
        } elsif ($color <= 76) {
            $result .= $map->{51};
        } elsif ($color <= 127) {
            $result .= $map->{102};
        } elsif ($color <= 178) {
            $result .= $map->{153};
        } elsif ($color <= 229) {
            $result .= $map->{204};
        } else {
            $result .= $map->{255};
        }
    }
    say "Output: \"$result\"";
}

nearest_rgb("#F4B2D1");
nearest_rgb("#15E6E5");
nearest_rgb("#191A65");
nearest_rgb("#2D5A1B");
nearest_rgb("#00FF66");
