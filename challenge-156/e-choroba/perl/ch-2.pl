#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ sum };
use Memoize qw{ memoize flush_cache };

sub is_weird_number ($n) {
    my @divisors = (1);
    for my $d (2 .. sqrt $n) {
        push @divisors, $d, $n / $d if 0 == $n % $d;
    }
    pop @divisors if @divisors > 1 && $divisors[-1] == $divisors[-2];

    return $n <= sum(@divisors) && ! do {
        flush_cache('sums_to');
        sums_to($n, @divisors) }
}

memoize('sums_to');
sub sums_to ($sum, @numbers) {
    return $numbers[0] == $sum if 1 == @numbers;
    my $s = sum(@numbers);
    return $s == $sum if $s <= $sum;

    for my $i (0 .. $#numbers) {
        return 1 if sums_to($sum, @numbers[ grep $_ ne $i, 0 .. $#numbers ]);
    }
    return 0
}

use Test::More tests => 854;

ok ! is_weird_number(12), 'Example 1';
ok is_weird_number(70), 'Example 2';

ok is_weird_number($_), "weird $_"
    for 836, 4030, 5830, 7192, 7912, 9272, 10430, 10570, 10792, 10990,
        11410, 11690, 12110, 12530, 12670, 13370, 13510, 13790, 13930,
        14770;

ok ! is_weird_number($_), "not weird $_" for 2 .. 11, 13 .. 69, 71 .. 835;
