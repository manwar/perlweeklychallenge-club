#! /usr/bin/perl6

use Test;

plan 1;

is(fibstr("1234","5678",51),'7','example 1');

sub fibstr($aa,$bb,$limit) {
    my $a=$aa;
    my $b=$bb;
    loop {
        my $c=$a ~ $b;
        say $c;
        if (chars($c) >= $limit) {
            return substr($c,$limit-1,1);
        }
        ($a,$b)=($b,$c);
    }
}
