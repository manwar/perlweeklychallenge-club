#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(pernicious(10),
          [3, 5, 6, 7, 9, 10, 11, 12, 13, 14],
          'example 1');

sub isprime($candidate) {
    if (!is-prime($candidate)) {
        return False;
    } elsif ($candidate==2) {
        return True;
    } elsif ($candidate==3) {
        return True;
    } elsif ($candidate % 2 == 0) {
        return False;
    } elsif ($candidate % 3 == 0) {
        return False;
    }
    my $anchor=0;
    my $limit=floor(sqrt($candidate));
    while (True) {
        $anchor+=6;
        for ($anchor-1,$anchor+1) -> $t {
            if ($t > $limit) {
                return True;
            }
            if ($candidate % $t == 0) {
                return False;
            }
        }
    }
}

sub hammingweight($x0) {
    my $x=$x0;
    my $count=0;
    while ($x > 0) {
        $x +&= ($x-1);
        $count++;
    }
    return $count;
}

sub pernicious($n) {
    my @out;
    my $c=1;
    while (True) {
        if (isprime(hammingweight($c))) {
            @out.push($c);
            if (@out.elems >= $n) {
                last;
            }
        }
        $c++;
    }
    return @out;
}
