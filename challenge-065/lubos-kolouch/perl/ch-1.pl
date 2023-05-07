use strict;
use warnings;

sub numbers_with_sum_of_digits {
    my ($N, $S) = @_;
    return helper($N, $S, 0, $N);
}

sub helper {
    my ($n, $s, $current, $N) = @_;
    return $s == 0 ? [$current] : [] if $n == 0;

    my @numbers;
    for my $i (0..9) {
        if ($n == $N && $i == 0) {  # First digit can't be 0
            next;
        }
        if ($s - $i >= 0) {
            push @numbers, @{helper($n - 1, $s - $i, $current * 10 + $i, $N)};
        }
    }
    return \@numbers;
}

my $N = 2;
my $S = 4;

print join(', ', @{numbers_with_sum_of_digits($N, $S)}), "\n";  # Output: 13, 22, 31, 40

