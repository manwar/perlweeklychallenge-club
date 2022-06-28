use strict;
use warnings;
use feature "say";

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}
sub is_abundant {
    my $n = shift;
    my @divisors = grep {$n % $_ == 0} 1..$n/2;
    return sum(@divisors) > $n ? 1 : 0;
}
my $n = 1;
my $count = 0;
while ($count < 20) {
    if (is_abundant $n) {
        say $n;
        $count++;
    }
    $n += 2;
}
