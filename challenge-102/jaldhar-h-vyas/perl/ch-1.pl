#!/usr/bin/perl
use 5.020;
use warnings;

sub isRare {
    my ($r, $r1) = @_;
    my $x = sqrt($r + $r1);
    if ($r1 > $r) {
        return undef;
    }
    my $y = sqrt($r - $r1);
    return $x == int($x) && $y == int($y);
} 

my ($N) = @ARGV;

my $xfactor = $N < 3 ? 11 : 121;
my $yfactor =  $N < 4 ? 11 : 1089;

for my $n ((10 ** ($N - 1)) .. ((10 ** $N) - 1)) {
    my $r = $n;
    my $r1 = 0 + reverse "$n";

    if ($r == $r1) {
        next;
    }

    if ($N % 2 == 0) {
        if (($r + $r1) % $xfactor == 0 && isRare($r, $r1)) {
            say $r;
        }
    } else {
        if (($r - $r1) % $yfactor == 0 && isRare($r, $r1)) {
            say $r;
        }
    }
}
