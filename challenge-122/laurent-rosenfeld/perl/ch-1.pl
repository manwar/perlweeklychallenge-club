use strict;
use warnings;
use feature "say";

my @n = (10, 20, 30, 40, 50, 60, 70, 80, 90, 100);
my @mvg_avg = ($n[0]);
for my $i (1..9) {
    $mvg_avg[$i] = ($mvg_avg[$i-1] * $i + $n[$i]) / ($i + 1);
}
say "@mvg_avg";
