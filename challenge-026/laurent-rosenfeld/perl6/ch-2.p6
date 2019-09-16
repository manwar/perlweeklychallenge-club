use v6;
use Test;

sub deg2rad (Numeric $deg) { return $deg * pi /180; }
sub rad2deg (Numeric $rad) { return $rad * 180 / pi }

sub mean (*@degrees) {
    my @radians = map { deg2rad $_ }, @degrees;
    my $count = @radians.elems;
    my $avg-sin = ([+] @radians.map( {sin $_})) / $count;
    my $avg-cos = ([+] @radians.map( {cos $_})) / $count;
    return rad2deg atan2 $avg-sin, $avg-cos;
}
plan 9;
is deg2rad(0), 0, "To rad: 0 degree";
is deg2rad(90), pi/2, "To rad: 90 degrees";
is deg2rad(180), pi, "To rad: 180 degrees";
is rad2deg(pi/2), 90, "To degrees: 90 degrees";
is rad2deg(pi), 180, "To degrees: 180 degrees";
is deg2rad(rad2deg(pi)), pi, "Roundtrip rad -> deg -> rad";
is rad2deg(deg2rad(90)), 90, "Roundtrip deg -> rad -> deg";
is-approx mean(10, 20, 30), 20, "Mean of 10, 20, 30 degrees";
is-approx mean(355, 5, 15), 5, "Mean of 355, 5, 15 degrees";
