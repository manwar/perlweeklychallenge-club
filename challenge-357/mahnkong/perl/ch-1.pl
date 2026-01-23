use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($int) {
    return -1 if $int =~ /\D/ or length($int) != 4;
    my %seen;
    $seen{$_}++ for split //, $int;
    return -1 if scalar(keys(%seen)) < 2;

    my $iterations = 0;

    while (1) {
        last if $int == 6174;
        my @int = split(//, $int);
        $int = sprintf("%04d", join("", sort { $b <=> $a } @int) - join("", sort { $a <=> $b } @int));
        $iterations += 1;
    }

    return $iterations;
}

is(run(3524), 3, 'Example 1');
is(run(6174), 0, 'Example 2');
is(run(9998), 5, 'Example 3');
is(run(1001), 4, 'Example 4');
is(run(9000), 4, 'Example 5');
is(run(1111), -1, 'Example 6');
