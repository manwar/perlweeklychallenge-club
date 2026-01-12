use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my %next = (1 => 2, 2 => 1);

sub run($int) {
    my $sequence = "";
    for (my $i = 1; $i <= $int; $i++) {
        my $amount = $sequence ? substr($sequence, -1) : 1;
        my $next = $sequence ? $next{substr($sequence, -1)} : 1;

        $sequence .= $next x $amount;
    }
    return () = $sequence =~ /1+/g;
}

is(run(4), 2, 'Example 1');
is(run(5), 3, 'Example 2');
is(run(6), 3, 'Example 3');
is(run(7), 4, 'Example 4');
is(run(8), 4, 'Example 5');
