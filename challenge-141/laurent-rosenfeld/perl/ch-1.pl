use strict;
use warnings;
use feature "say";

sub has_8_divisors {
    my $n = shift;
    my @divisors = grep {$n % $_ == 0} 1..$n;
    return @divisors == 8;
}

my $count = 0;
for my $m (8..1_000_000) {
    say $m and $count++ if has_8_divisors $m;
    last if $count >= 10;
}
