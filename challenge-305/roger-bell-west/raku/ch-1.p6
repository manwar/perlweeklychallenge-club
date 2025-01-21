#! /usr/bin/raku

use Test;

plan 3;

is-deeply(binaryprefix([1, 0, 1]), [False, True, True], 'example 1');
is-deeply(binaryprefix([1, 1, 0]), [False, True, False], 'example 2');
is-deeply(binaryprefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]), [False, True, True, False, False, True, False, False, False, False, False, False, False, False, False, False, False, False, False, True], 'example 3');

sub is_prime($candidate) {
    if (!is-prime($candidate)) {
        return False;
    } elsif ($candidate < 2) {
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

sub binaryprefix(@a) {
    my @out;
    my $n = 0;
    for @a -> $x {
        $n *= 2;
        if ($x == 1) {
            $n++;
        }
        @out.push(is_prime($n));
    }
    @out;
}
