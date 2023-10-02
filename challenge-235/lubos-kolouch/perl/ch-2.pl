use strict;
use warnings;

sub duplicate_zeros {
    my @ints = @_;
    my $zeros = grep { $_ == 0 } @ints;
    
    for (my $i = $#ints; $i >= 0 && $zeros > 0; $i--) {
        if ($i + $zeros < @ints) {
            $ints[$i + $zeros] = $ints[$i];
        }
        if ($ints[$i] == 0) {
            $zeros--;
            if ($i + $zeros < @ints) {
                $ints[$i + $zeros] = 0;
            }
        }
    }
    return @ints;
}

# Test cases
print join(", ", duplicate_zeros(1, 0, 2, 3, 0, 4, 5, 0)), "\n";  # Expected: 1, 0, 0, 2, 3, 0, 0, 4
print join(", ", duplicate_zeros(1, 2, 3)), "\n";  # Expected: 1, 2, 3
print join(", ", duplicate_zeros(0, 3, 0, 4, 5)), "\n";  # Expected: 0, 0, 3, 0, 0
