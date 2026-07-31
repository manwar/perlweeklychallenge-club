#!/usr/bin/env perl
#
=head1 Task 2: Nearest RGB

Submitted by: Mohammad Sajid Anwar

You are given a 6-digit hex color.  Write a script to round the RGB channels to
the nearest web-safe value and return the nearest RGB color.  00 (0), 33 (51),
66 (102), 99 (153), CC (204) and FF (255)

=head2 Example 1

    Input: $color = "#F4B2D1"
    Output: "#FF99CC"

    Red: F4 (Decimal 244), closer to 255 => FF
    Green: B2 (Decimal 178), closer to 153 => 99
    Blue: D1 (Decimal 209), closer to 204 => CC
    So the nearest RGB: "#FF99CC"

=head2 Example 2

    Input: $color = "#15E6E5"
    Output: "#00FFCC"

    Red: 15 (Decimal 21), closer to 0 => 00
    Green: E6 (Decimal 230), closer to 255 => FF
    Blue: E5 (Decimal 229), closer to 204 => CC

=head2 Example 3

    Input: $color = "#191A65"
    Output: "#003366"

    Red: 19 (Decimal 25), closer to 0 => 00
    Green: 1A (Decimal 26), closer to 51 => 33
    Blue: 65 (Decimal 101), closer to 102 => 66

=head2 Example 4

    Input: $color = "#2D5A1B"
    Output: "#336633"

    Red: 2D (Decimal 45), closer to 51 => 33
    Green: 5A (Decimal 90), closer to 102 => 66
    Blue: 1B (Decimal 27), closer to 51 => 33

=head2 Example 5

    Input: $color = "#00FF66"
    Output: "#00FF66"

    Red: 00 (Decimal 0), closer to 0 => 00
    Green: FF (Decimal 255), closer to 255 => FF
    Blue: 66 (Decimal 102), closer to 102 => 66

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {color => "#F4B2D1",
     out   => "#FF99CC",
     name  => "Example 1",
     },
    {color => "#15E6E5",
     out   => "#00FFCC",
     name  => "Example 2",
     },
    {color => "#191A65",
     out   => "#003366",
     name  => "Example 3",
     },
    {color => "#2D5A1B",
     out   => "#336633",
     name  => "Example 4",
     },
    {color => "#00FF66",
     out   => "#00FF66",
     name  => "Example 5",
     },
);

sub  nearest_rgb
{
    my $color = shift;

    my @ranges_dec = (  0,   51,  102,  153,  204,  255);
    my @ranges_hex = ('00', '33', '66', '99', 'CC', 'FF');

    my @rgb = map { hex($_) } $color =~ /#(..)(..)(..)/;

    for my $i (0 .. 2) {
        my $closest_idx = 0;
        for my $j (1..$#ranges_dec) {
            $closest_idx = $j if abs($rgb[$i] - $ranges_dec[$j]) <
                                 abs($rgb[$i] - $ranges_dec[$closest_idx]);
        }
        $rgb[$i] = $closest_idx;
    }
    return "#$ranges_hex[$rgb[0]]$ranges_hex[$rgb[1]]$ranges_hex[$rgb[2]]";
}

for my $case (@cases) {
    my $got = nearest_rgb($case->{color});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
