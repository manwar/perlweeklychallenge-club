use strict;
use warnings;
use feature "say";

sub gcd {
    my ($i, $j) = sort { $a <=> $b } @_;
    while ($j) {
        ($i, $j) = ($j, $i % $j);
    }
    return $i;
}

sub common_factors {
    my ($i, $j) = @_;
    my $gcd = gcd ($i, $j);
    return (1) if $gcd == 1;
    my @factors = grep { $gcd % $_ == 0 } 1..$gcd;
    my %unique = map {$_ => 1} @factors;
    return sort { $a <=> $b } keys %unique;
}
say join " ", common_factors @ARGV;
