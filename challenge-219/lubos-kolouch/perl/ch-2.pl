use strict;
use warnings;

sub min_cost {
    my ($costs, $days) = @_;
    my $N = $days->[-1] + 1;
    my @dp = (0) x $N;
    my %days = map { $_ => 1 } @$days;
    for my $i (1..$N-1) {
        if (!exists $days{$i}) {
            $dp[$i] = $dp[$i-1];
        }
        else {
            $dp[$i] = min(
                $dp[$i-1] + $costs->[0],
                $dp[max(0, $i-7)] + $costs->[1],
                $dp[max(0, $i-30)] + $costs->[2]
            );
        }
    }
    return $dp[-1];
}

sub min { my $min = shift; for (@_) { $min = $_ if $_ < $min } return $min }
sub max { my $max = shift; for (@_) { $max = $_ if $_ > $max } return $max }

# Tests
print min_cost([2, 7, 25], [1, 5, 6, 7, 9, 15]), "\n";  # Output: 11
print min_cost([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]), "\n";  # Output: 20

