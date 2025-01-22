use strict;
use feature 'signatures';
use experimental 'builtin';
use builtin qw(true false);
use Test::More 'no_plan';

sub is_prime($number) {
    return false if $number < 2;
    for (my $d = 2 ; $d < $number; $d++) {
        return false if $number % $d == 0;
    }
    return true;
}

sub run(@binary) {
    my @result;
    my $bin;
    foreach my $b (@binary) {
        $bin .= $b;
        my $dec = oct('0b'. $bin);
        push @result, is_prime($dec);
    }

    return @result;
}

is_deeply([run(1, 0, 1)], [(false, true, true)], "Example 1");
is_deeply([run(1, 1, 0)], [(false, true, false)], "Example 2");
is_deeply([run(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)], [(false, true, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, true)], "Example 3");
