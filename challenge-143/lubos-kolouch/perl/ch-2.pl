use strict;
use warnings;
use POSIX qw/floor/;

sub is_stealthy {
    my $n = shift;
    my @factors;
    for my $i (1..floor(sqrt($n))) {
        if ($n % $i == 0) {
            push @factors, [$i, $n / $i];
        }
    }

    for my $i (0..$#factors) {
        for my $j ($i..$#factors) {
            my ($a, $b) = @{$factors[$i]};
            my ($c, $d) = @{$factors[$j]};
            return 1 if $a + $b == $c + $d + 1;
        }
    }

    return 0;
}

print is_stealthy(36) ? "True\n" : "False\n";  # Output: True
print is_stealthy(12) ? "True\n" : "False\n";  # Output: True
print is_stealthy(6) ? "True\n" : "False\n";  # Output: False

