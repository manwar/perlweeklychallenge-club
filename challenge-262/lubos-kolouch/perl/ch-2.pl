use strict;
use warnings;


package Ch2;
use Carp;

sub count_equal_divisible {
    my ($ints_ref, $k) = @_;
    my @ints = @$ints_ref;
    my $count = 0;
    my $n = scalar @ints;

    for my $i (0 .. $n - 1) {
        for my $j ($i + 1 .. $n - 1) {
            if ($ints[$i] == $ints[$j] && ($i * $j) % $k == 0) {
                $count++;
            }
        }
    }
    return $count;
}

# Assert tests
croak "Test failed!" unless count_equal_divisible([3, 1, 2, 2, 2, 1, 3], 2) == 4;
croak "Test failed!" unless count_equal_divisible([1, 2, 3], 1) == 0;

1;