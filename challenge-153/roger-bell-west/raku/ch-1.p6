#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(leftfactorial(10),[1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114],'example 1');

sub leftfactorial($mx) {
    my @out;
    my $fact=1;
    my $sum=0;
    for (0..$mx-1) -> $i {
        if ($i > 0) {
            $fact *= $i;
        }
        $sum += $fact;
        @out.push($sum);
    }
    return @out;
}
