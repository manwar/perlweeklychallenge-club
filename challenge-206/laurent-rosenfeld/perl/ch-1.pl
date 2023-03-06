use strict;
use warnings;
use feature "say";

sub shortest {
    my $mod = 60 * 12;
    my ($h1, $m1) = split /:/, $_[0];
    my ($h2, $m2) = split /:/, $_[1];
    return abs ($m1 - $m2) if $h1 == $h2;
    my $delta = abs(($h1 * 60 + $m1) - ($h2 * 60 + $m2));
    $delta = $mod * 2 - $delta if $delta > $mod;
    return $delta
}

for my $test (["00:00", "23:55", "20:00"],
              ["01:01", "00:50", "00:57"],
              ["10:10", "09:30", "09:00", "09:55"]) {
    my $min = 10000;   # larger than any HH:MM time diff
    my @t = @$test;
    for my $i (0..$#t) {
        for my $j ($i+1..$#t) {
            my $diff = shortest $t[$i], $t[$j];
            $min = $diff if $diff < $min;
        }
    }
    printf "%-25s => %d\n", "@t", $min;
}
