sub ugly-ith ( UInt:D $n'th where * != 0 ) {
    state $Hammings = gather {
        class Ham {
            has Int      $.C;
            has Int      $.N = 1;
            has Iterator $!I = $Hammings.iterator;
            method bump ( ) {
                $!N = $.C * $!I.pull-one;
            }
        }

        my @cin = map { Ham.new: :C($_) }, 2, 3, 5;

        loop {
            take my $taken = @cin».N.min;
            .bump if .N == $taken for @cin;
        }
    }
    return $Hammings[$n'th - 1];
}

use Test;
my @tests = ( # https://oeis.org/A051037
    1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, 32, 36, 40, 45, 48, 50, 54, 60, 64, 72, 75, 80, 81, 90, 96, 100, 108, 120, 125, 128, 135, 144, 150, 160, 162, 180, 192, 200, 216, 225, 240, 243, 250, 256, 270, 288, 300, 320, 324, 360, 375, 384, 400, 405
);
plan +@tests;
for @tests.kv -> $i, $expected {
    my $ordinal = $i + 1;
    is ugly-ith($ordinal), $expected, "ugly-ith($ordinal) == $expected";
}
