#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(padovanprime(10),
          [2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281,
           3093215881333057],
          'example 1');

sub padovanprime($ct) {
    my $pp=SetHash.new;
    for (1, 1, 1, -> $a, $b, $c { $a + $b } ... *) -> $padovan {
        if (isprime($padovan)) {
            $pp{$padovan}=True;
            if $pp.elems >= $ct {
                last;
            }
        }
    }
    return [$pp.keys.sort];
}

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
