use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($int) {
    my @numbers = (0, 1);
    while (1) {
        my $next = $numbers[-2] + $numbers[-1];
        if ($next > $int) {
            last;
        } else {
            push @numbers, $numbers[-2] + $numbers[-1];
        }
    }
    my @result;
    my $sum = 0;
    my $current = $#numbers;
    while ($current >= 0) {
        if ($sum + $numbers[$current] <= $int) {
            $sum += $numbers[$current];
            push @result, $numbers[$current];
            $current -= 2;
            last if $sum == $int;
        } else {
            $current -= 1;
        }
    }

    return [ @result ];
}

is_deeply(run(4), [3,1], 'Example 1');
is_deeply(run(12), [8,3,1], 'Example 2');
is_deeply(run(20), [13,5,2], 'Example 3');
is_deeply(run(96), [89,5,2], 'Example 4');
is_deeply(run(100), [89,8,3], 'Example 5');
