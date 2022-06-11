use strict;
use warnings;
use feature "say";

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub combine {
    my ($test, $comb, $div) = @_;
    my @comb_so_far = @$comb;
    my @divisors = @$div;
    # say "(@comb_so_far) (@divisors)";
    return 0 if sum(@comb_so_far) == $test;
    return 1 if scalar @divisors == 0;
    for my $i (0..$#divisors) {
        my $result = combine($test, [@comb_so_far, $divisors[$i]],
                             [@divisors[($i+1)..$#divisors]]);
        return 0 if $result == 0;
    }
    return 1;
}

sub is_weird {
    my $n = shift;
    my @divisors = grep {$n % $_ == 0} 1..($n/2);
    return 0 if sum(@divisors) <= $n;
    return combine($n, [], [@divisors]);
}

for my $m (2..6000) {
    say "Found $m" if is_weird($m);
}
