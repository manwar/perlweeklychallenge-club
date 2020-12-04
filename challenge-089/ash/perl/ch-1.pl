# To run, install Math::Utils first:
# $ cpanm Math::Utils
# $ perl ch-1.pl 100
# 13015

use v5.12;

use Math::Utils qw(gcd);

my $n = $ARGV[0] // 3;

my $s = 0;
for my $x (1 .. $n) {
    for my $y ($x + 1 .. $n) {
        $s += gcd($x, $y);
    }
}

say $s;
