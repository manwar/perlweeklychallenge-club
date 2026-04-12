#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';


while (<>) {
    my ($number, $mode) = split;
    my $diff_factors = 0;
    my      $factors = 0;

    #
    # Try dividing by all odd numbers -- but use 2 if the number is 1.
    # Count different and total factors.
    #
    # Note that this way, we will never divide by a composite number --
    # if we encounter a composite number, we have already tried its factors.
    #
    for (my $d = 1; $d * $d <= $number; $d += 2) {
        use integer;  # Avoid rounding errors
        my $n = $d == 1 ? 2 : $d;
        if ($number % $n == 0) {
            $diff_factors ++;
            while ($number % $n == 0) {
                $factors ++;
                $number /= $n;
            }
        }
    }

    #
    # At this point, $number is either 1 or a large prime, not encountered
    # before. In the later case, add one of the number of factors and unique
    # factors.
    #
    if ($number != 1) {
        $diff_factors ++;
        $factors ++;
    }
    say $mode ? $factors : $diff_factors;
}


__END__
