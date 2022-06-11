use strict;
use warnings;


sub calculate_factorial {
    my $what = shift;

    my $fact = 1;

    $fact *= $_ for (1..$what);

    return $fact;
}

sub get_factorions_sum {
    my $what = shift;

    my $sum = 0;

    $sum += calculate_factorial($_) for (split //, $what);
    return $sum;
}


sub is_equal {
    my $what = shift;
    return $what == get_factorions_sum($what);
}

use Test::More;
is(is_equal(145), 1);
is(is_equal(123), '');
done_testing;
