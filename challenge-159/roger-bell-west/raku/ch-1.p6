#! /usr/bin/perl6

use Test;

plan 3;

is-deeply(farey(5),(
              0 => 1, 1 => 5, 1 => 4, 1 => 3, 2 => 5, 1 => 2, 3 => 5,
              2 => 3, 3 => 4, 4 => 5, 1 => 1
          ),'example 1');

is-deeply(farey(7),(
              0 => 1, 1 => 7, 1 => 6, 1 => 5, 1 => 4, 2 => 7, 1 => 3,
              2 => 5, 3 => 7, 1 => 2, 4 => 7, 3 => 5, 2 => 3, 5 => 7,
              3 => 4, 4 => 5, 5 => 6, 6 => 7, 1 => 1
          ),'example 2');

is-deeply(farey(4),(
              0 => 1, 1 => 4, 1 => 3, 1 => 2, 2 => 3, 3 => 4, 1 => 1
          ),'example 3');

sub gcd($m0,$n0) {
    my ($m,$n)=($m0,$n0);
    while ($n != 0) {
        ($m,$n)=($n,$m % $n);
    }
    return $m;
}

sub lcm($m,$n) {
    return $m/gcd($m,$n)*$n;
}

sub lcmseries(@s) {
    return floor(@s.reduce(&lcm));
}

sub farey($n) {
    my $l=lcmseries([2..$n]);
    my %d;
    for (1..$n) -> $i {
        my $m = $l div $i;
        for (0..$i) -> $j {
            my $k = $m * $j;
            unless (%d{$k}:exists) {
                %d{$k}=Pair.new($j,$i);
            }
        }
    }
    return map {%d{$_}}, sort { $^a <=> $^b }, %d.keys;
}
