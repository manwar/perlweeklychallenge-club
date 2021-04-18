#!/usr/bin/perl
use 5.020;
use warnings;

sub bellNumber {
    my ($n) = @_;
    my @bell;
    $bell[0][0] = 1;
    for my $i (1 .. $n) {
        $bell[$i][0] = $bell[$i - 1][$i - 1];
 
        for my $j (1 .. $i) {
            $bell[$i][$j] = $bell[$i - 1][$j - 1] + $bell[$i][$j - 1];
        }
    }
    return $bell[$n][0];
}
 
for my $n (0 .. 9) {
    print bellNumber($n), q{ };
}
print "\n";
