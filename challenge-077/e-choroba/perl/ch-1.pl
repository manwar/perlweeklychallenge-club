#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Memoize;

memoize('fibonacci');
sub fibonacci {
    my ($n) = @_;
    my ($f1, $f2) = (1, 1);
    for (1 .. $n) {
        ($f1, $f2) = ($f2, $f1 + $f2);
    }
    return $f1
}

memoize('fibonacci_sum');
sub fibonacci_sum {
    my ($n) = @_;
    return [[1]] if 1 == $n;

    my @sum;
    my $start_index = 1;
    while ((my $start_f = fibonacci($start_index)) <= $n) {

        push @sum, [$n]
            and last
            if $n == $start_f;

        my $index = $start_index;
        while ((my $f = fibonacci($index)) <= $n / 2) {
            no warnings 'recursion';
            my $s = fibonacci_sum($n - $f);

            my @s = map [$f, @$_],
                    grep $f < $_->[0],
                    @$s
                or last;

            push @sum, @s;
            ++$index;
        }
        ++$start_index;
    }

    return \@sum
}

sub pretty_print {
    my ($n) = @_;
    for my $s (@{ fibonacci_sum($n) }) {
        say join(' + ', @$s), " = $n";
    }
}

use Test::More;

is fibonacci(0), 1;
is fibonacci(1), 1;
is fibonacci(2), 2;
is fibonacci(3), 3;
is fibonacci(4), 5;

is_deeply fibonacci_sum(1),  [[1]],                              'one';
is_deeply fibonacci_sum(2),  [[2]],                              'two';
is_deeply fibonacci_sum(3),  [[1, 2], [3]],                      'three';
is_deeply fibonacci_sum(4),  [[1, 3]],                           'four';
is_deeply fibonacci_sum(5),  [[2, 3], [5]],                      'five';
is_deeply fibonacci_sum(6),  [[1, 2, 3], [1, 5]],                'six';
is_deeply fibonacci_sum(7),  [[2, 5]],                           'seven';
is_deeply fibonacci_sum(8),  [[1, 2, 5], [3, 5], [8]],           'eight';
is_deeply fibonacci_sum(9),  [[1, 3, 5], [1, 8]],                'nine';
is_deeply fibonacci_sum(10), [[2, 3, 5], [2, 8]],                'ten';
is_deeply fibonacci_sum(11), [[1, 2, 3, 5], [1, 2, 8], [3, 8]],  'eleven';
is_deeply fibonacci_sum(12), [[1, 3, 8]],                        'twelve';
is_deeply fibonacci_sum(13), [[2, 3, 8], [5, 8], [13]],          'thirteen';
is_deeply fibonacci_sum(14), [[1, 2, 3, 8], [1, 5, 8], [1, 13]], 'fourteen';

done_testing();

pretty_print(18200); # Takes about 5s.
