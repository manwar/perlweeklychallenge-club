use strict;
use warnings;
use feature "say";

sub find_angle {
    my $time = shift;
    my ($h, $m) = split /:/, $time;
    # angles counted in deg clockwise from the 0/12 position
    my $m_angle = $m * 6; # or: $m * 360/60
    # for the short hand:
    #     1 hr = 360 / 12 = 30 degrees
    #     1 min = #m_angle / (360 / 30) = #m_angle /12
    my $h_angle = ($h * 30 + $m_angle / 12) % 360;
    my $hands_angle = abs($h_angle - $m_angle);
    return  $hands_angle <= 180 ? $hands_angle : 360 - $hands_angle;
}

for my $t (qw / 03:10 04:00 07:00 15:10 18:00 /) {
    say "$t: ", find_angle $t;
}
