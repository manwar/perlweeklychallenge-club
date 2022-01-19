use strict;
use warnings;
use feature "say";

sub count_divisors {
    my ($m, $n) = @_;
    my @divisors = grep {$m % $_ == 0} 1..$m;
    my $last_digit = substr $n, -1, 1;
    my @eligible_divisors = grep { $last_digit == substr $_, -1, 1 } @divisors;
    return scalar @eligible_divisors;
}
for ([24, 34], [24, 12], [30, 45]) {
  say "@$_ -> ", count_divisors $_->[0], $_->[1];
}
