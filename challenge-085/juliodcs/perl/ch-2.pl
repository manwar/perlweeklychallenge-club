use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use Math::BigFloat;

sub power_of_2_ints($number) {
    my $num = Math::BigFloat->new($number);
    foreach my $x (2 .. $num / 2) {
        if ($num % $x == 0) {
            my $log = log($num)/log($x);
            return $log->bround(2) == int $log;
        }
    }
    return 0;
}

if (@ARGV > 0) {
    say power_of_2_ints(+shift);
    exit 0;
}

use Test::More;

ok  power_of_2_ints(4), '2^2 = 4';
ok  power_of_2_ints(8), 'Test case 1';
ok !power_of_2_ints(15), 'Test case 2';
ok  power_of_2_ints(125), 'Test case 3';

done_testing;
