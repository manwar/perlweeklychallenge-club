use v5.30.0;
use warnings;

sub fe {
    my $s = $_[0];
    my %alphabet;
    $alphabet{$_} = 1 for split "", $s;
    my %freq;
    my $minfreq = scalar split "", $s;
    for my $w (keys %alphabet) {
        $freq{$w} = scalar grep {$_ eq $w} split "", $s;
        $minfreq = $freq{$w} if $minfreq > $freq{$w};
    }
    my $ans = 0;
    $ans += $freq{$_} - $minfreq foreach keys %freq;
    return $ans;
}

use Test::More tests=>4;
ok fe("abbc") == 1;
ok fe("xyzyyxz") == 1;
ok fe("xzxz") == 0;
ok fe("xxyyz") == 2;
