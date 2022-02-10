use strict;
use warnings;
use feature "say";

sub fibonacci {
    my ($a, $b) = @_;
    my @fib = $a < $b ? ($a, $b) : ($b, $a);
    for my $i (1..20) {
        push @fib, $fib[-2] . $fib[-1];
        next if length $fib[-1] < 51;
        say $fib[-1];
        return $fib[-1];
    }
}
say substr fibonacci(1234, 5678), 50, 1;
