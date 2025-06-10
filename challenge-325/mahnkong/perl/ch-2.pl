use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@prices) {
    my @result;

    for (my $i = 0; $i < $#prices; $i++) {
        my $price = $prices[$i];
        for (my $j = $i + 1; $j <= $#prices; $j++) {
            if ($prices[$j] <= $price) {
                $price = $price - $prices[$j];
                last;
            }
        }
        push @result, $price;
    }

    return [@result, $prices[-1]];
}

is_deeply(run(8, 4, 6, 2, 3), [4, 2, 4, 2, 3], "Example 1");
is_deeply(run(1, 2, 3, 4, 5), [1, 2, 3, 4, 5], "Example 2");
is_deeply(run(7, 1, 1, 5), [6, 0, 1, 5], "Example 3");
