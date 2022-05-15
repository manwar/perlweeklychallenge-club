use strict;
use warnings;
use feature "say";

sub is_prime {
    my $num = shift;
    return 1 if $num == 2;
    return 0 unless $num % 2;
    my $test = 3;
    while ($test < $num/2) {
        return 0 if $num % $test == 0;
        $test += 2;
    }
    return 1;
}

say map "$_ ", grep { is_prime $_} grep {$_ == reverse $_} 1..999;
