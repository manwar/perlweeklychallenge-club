use strict;
use warnings;
use feature "say";

sub fact {
    my $i = shift;
    my $prod = 1;
    $prod *= $_ for 2..$i;
    return $prod;
}

my @digit_fact = map {fact $_} 0..9;

sub is_factorion {
    my $in = shift;
    my $sum = 0;
    $sum += $_ for map { $digit_fact[$_] } split //, $in;
    return $sum == $in;
    #say $sum;
}
for (1..50000) {
    say $_ if is_factorion($_)
}
