use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use List::Util 'first';

sub power_of_ints($n) {
    return 0 unless my $base = first { $n % $_ == 0 } (2 .. $n / 2);
    return $n == $base ** int(0.5 + log($n)/log($base))
}

if (@ARGV > 0) {
    say power_of_ints(+shift);
    exit 0;
}

use Test::More;

ok !power_of_ints(1), 'Number 1';

ok  power_of_ints(4), '2^2 = 4';
ok  power_of_ints(8), 'Test case 1';
ok !power_of_ints(15), 'Test case 2';
ok  power_of_ints(125), 'Test case 3';
ok  power_of_ints(64), 'Test case 3';
ok  power_of_ints(2197), '13^3';
ok !power_of_ints(2198), '13^3 + 1';
ok !power_of_ints(2196), '13^3 - 1';
ok !power_of_ints(4394), '13^3 * 2';

done_testing;
