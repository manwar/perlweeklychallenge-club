use strict;
use warnings;
use feature "say";

for my $test ([1,3,5,6,9], [2,4,6,8,10], [1,2,3,4,5]) {
    my @in = @$test;
    my $n = scalar @in;

    my $sum = 0;
    $sum += $_ for @in;
    my $am = $sum / $n;

    my $prod = 1;
    $prod *= $_ for @in;
    my $gm = $prod ** (1/$n);

    my $invsum = 0;
    $invsum += 1/$_ for @in;
    my $hm = $n / $invsum;
    printf  "%-10s -> AM: %0.1f, GM: %0.1f, HM: %0.1f\n", "@in", $am, $gm, $hm;
}
