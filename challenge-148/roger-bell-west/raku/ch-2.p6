#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(cardano(5),[[2,1,5],[5,1,52],[5,2,13],[8,1,189],[8,3,21]],'example 1');

sub cardano($ct) {
    my @out;
    my $k=0;
    my $cn=0;
    while (1) {
        my $a=3*$k+2;
        my $b2c=($k+1)*($k+1)*(8*$k+5);
        my $b=0;
        my $b2=0;
        my $inc=1;
        while (1) {
            $b++;
            $b2+=$inc;
            $inc+=2;
            if ($b2 > $b2c) {
                last;
            }
            if ($b2c % $b2 == 0) {
                push @out,[$a,$b,$b2c div $b2];
                $cn++;
                if ($cn >= $ct) {
                    last;
                }
            }
        }
        if ($cn >= $ct) {
            last;
        }
        $k++;
    }
    return @out;
}
