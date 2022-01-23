use strict;
use warnings;
use feature "say";
use constant MAX => 5;

sub is_cardano_triplet {
    my ($a, $b, $c) = @_;
    return 0 if $a - $b * sqrt($c) > 0;
    my $val = (($a + $b * sqrt($c)) ** (1/3)) - ((- $a + $b * sqrt($c)) ** (1/3));
    # say $val;
    return abs($val - 1) < 0.000001;
}

my @values = 1..100;
my $count = 0;
OUT: for my $i (@values) {
    for my $j (@values) {
        for my $k (@values) {
            if (is_cardano_triplet $i, $j, $k) {
                say "$i $j $k";
                $count++;
                last OUT if $count >= MAX;
            }
        }
    }
}
