use v5.30.0;
use warnings;

sub dc {
    for my $d (reverse 0..9) {
        my $clock = $_[0];
        $clock =~ s/\?/$d/g;
        $clock =~ m/(\d{2}):(\d{2})/;
        my ($h, $m) = ($1, $2);
        $h =~ s/^0//;
        $m =~ s/^0//;
        if ($h < 24 && $m < 60) {
            return $d;
        }
    }
}


use Test::More tests=>6;
ok dc("?5:00") == 1;
ok dc("?3:00") == 2;
ok dc("1?:00") == 9;
ok dc("2?:00") == 3;
ok dc("12:?5") == 5;
ok dc("12:5?") == 9;
