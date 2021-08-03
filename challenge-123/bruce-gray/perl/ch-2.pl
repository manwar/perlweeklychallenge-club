use strict;
use warnings;
use 5.020;
use experimental qw<signatures>;
use List::Util   qw<min>;
use Test::More;

sub ugly_ith ( $nth ) {
    state $Hammings = [];

    state $cin = [ map { { C => $_, N => 1, I => 0 } } 2, 3, 5 ];
    while ( @{$Hammings} < $nth ) {
        my $taken = min map { $_->{N} } @{$cin};
        push @{$Hammings}, $taken;

        for (@{$cin}) {
            if ($_->{N} == $taken) {
                $_->{N} = $_->{C} * $Hammings->[ $_->{I} ];
                $_->{I}++;
            }
        }
    }

    return $Hammings->[$nth - 1];
}

use Test::More;
my @tests = ( # https://oeis.org/A051037
    1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, 32, 36, 40, 45, 48, 50, 54, 60, 64, 72, 75, 80, 81, 90, 96, 100, 108, 120, 125, 128, 135, 144, 150, 160, 162, 180, 192, 200, 216, 225, 240, 243, 250, 256, 270, 288, 300, 320, 324, 360, 375, 384, 400, 405
);
plan tests => 0+@tests;
for my $i ( keys @tests ) {
    my $expected = $tests[$i];
    my $ordinal  = $i + 1;
    is ugly_ith($ordinal), $expected, "ugly-ith($ordinal) == $expected";
}
