#! /usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

my @F = (1, 2);
sub fibonacci_sequence {
    my ($n) = @_;
    my $count = 0;
    my $indicator = 1;
    my $bin = 1;
    while ($F[ length($bin) - 1 ] <= $n) {
        push @F, $F[-2] + $F[-1] if @F <= length $bin;
        my $sum = sum(@F[ grep substr($bin, -$_ - 1, 1),
                               0 .. length($bin) - 1 ]);
        ++$count if $sum == $n;
        ++$indicator;
        $bin = sprintf '%b', $indicator;
    }
    return $count
}

use Test2::V0;
plan 52;

is fibonacci_sequence(16), 4, 'Example 1';
is fibonacci_sequence(9), 2, 'Example 2';
is fibonacci_sequence(15), 2, 'Example 3';

# Used $n ** 2 instead of $n in the while condition to verify the numbers are
# correct.

is fibonacci_sequence(17), 2, 'Check 17';
is fibonacci_sequence(18), 3, 'Check 18';
is fibonacci_sequence(19), 3, 'Check 19';
is fibonacci_sequence(20), 1, 'Check 20';
is fibonacci_sequence(21), 4, 'Check 21';
is fibonacci_sequence(22), 3, 'Check 22';
is fibonacci_sequence(23), 3, 'Check 23';
is fibonacci_sequence(24), 5, 'Check 24';
is fibonacci_sequence(25), 2, 'Check 25';
is fibonacci_sequence(26), 4, 'Check 26';
is fibonacci_sequence(27), 4, 'Check 27';
is fibonacci_sequence(28), 2, 'Check 28';
is fibonacci_sequence(29), 5, 'Check 29';
is fibonacci_sequence(30), 3, 'Check 30';
is fibonacci_sequence(31), 3, 'Check 31';
is fibonacci_sequence(32), 4, 'Check 32';
is fibonacci_sequence(33), 1, 'Check 33';
is fibonacci_sequence(34), 4, 'Check 34';
is fibonacci_sequence(35), 4, 'Check 35';
is fibonacci_sequence(36), 3, 'Check 36';
is fibonacci_sequence(37), 6, 'Check 37';
is fibonacci_sequence(38), 3, 'Check 38';
is fibonacci_sequence(39), 5, 'Check 39';
is fibonacci_sequence(40), 5, 'Check 40';
is fibonacci_sequence(41), 2, 'Check 41';
is fibonacci_sequence(42), 6, 'Check 42';
is fibonacci_sequence(43), 4, 'Check 43';
is fibonacci_sequence(44), 4, 'Check 44';
is fibonacci_sequence(45), 6, 'Check 45';
is fibonacci_sequence(46), 2, 'Check 46';
is fibonacci_sequence(47), 5, 'Check 47';
is fibonacci_sequence(48), 5, 'Check 48';
is fibonacci_sequence(49), 3, 'Check 49';
is fibonacci_sequence(50), 6, 'Check 50';
is fibonacci_sequence(51), 3, 'Check 51';
is fibonacci_sequence(52), 4, 'Check 52';
is fibonacci_sequence(53), 4, 'Check 53';
is fibonacci_sequence(54), 1, 'Check 54';
is fibonacci_sequence(55), 5, 'Check 55';
is fibonacci_sequence(56), 4, 'Check 56';
is fibonacci_sequence(57), 4, 'Check 57';
is fibonacci_sequence(58), 7, 'Check 58';
is fibonacci_sequence(59), 3, 'Check 59';
is fibonacci_sequence(60), 6, 'Check 60';
is fibonacci_sequence(61), 6, 'Check 61';
is fibonacci_sequence(62), 3, 'Check 62';
is fibonacci_sequence(63), 8, 'Check 63';
is fibonacci_sequence(64), 5, 'Check 64';
is fibonacci_sequence(65), 5, 'Check 65';
