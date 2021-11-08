use strict;
use warnings;
use feature "say";

sub sum_squares {
    my $n = shift;
    my $sum_sq = 0;
    $sum_sq += $_ ** 2 for split //, $n;
    my $sqrt_int = int sqrt $sum_sq;
    return $sqrt_int ** 2 == $sum_sq ? 1 : 0;
}
say "$_: ", sum_squares $_ for 10..71;
