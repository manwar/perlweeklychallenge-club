use strict;
use warnings;
use feature "say";

sub moebius {
    my $n = shift;
    my %factors;
    for my $i (2..$n) {
        while  ($n % $i == 0) {
            $factors{$i}++;
            $n /= $i;
        }
    }
    return 0 if grep $_ > 1, values %factors;
    return 1 unless (scalar keys %factors) % 2;
    return -1;
}
say "$_: ", moebius $_ for 1..20;
