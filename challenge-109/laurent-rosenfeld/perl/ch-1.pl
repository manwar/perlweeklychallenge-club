use strict;
use warnings;
use feature "say";

sub chowla {
    my $n = shift;
    return 0 if $n <= 2;
    my @divisors = grep {$n % $_== 0} 2..($n / 2);
    my $sum = 0;
    $sum += $_ for @divisors;
    return $sum;
}
say join ", ", map { chowla $_} 1..20;
