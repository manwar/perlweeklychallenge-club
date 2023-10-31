use strict;
use warnings;

sub prime_factors {
    my $n = shift;
    my @factors;
    while ($n % 2 == 0) {
        push @factors, 2;
        $n /= 2;
    }
    for (my $i = 3; $i <= sqrt($n); $i += 2) {
        while ($n % $i == 0) {
            push @factors, $i;
            $n /= $i;
        }
    }
    push @factors, $n if $n > 2;
    return \@factors;
}

sub sort_by_prime_factors {
    my @nums = @_;
    my @sorted_nums = sort { scalar(@{prime_factors($a)}) <=> scalar(@{prime_factors($b)}) || $a <=> $b } @nums;
    return \@sorted_nums;
}

# Test Cases
print join(", ", @{sort_by_prime_factors(11, 8, 27, 4)}), "\n";  # Output: 11, 4, 8, 27
