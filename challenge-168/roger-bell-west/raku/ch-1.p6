#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(perrinprime(13),
          (2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977),
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

sub perrinprime($n) {
    my $out = SetHash.new;
    my @seq = (3, 0, 2);
    while (True) {
        @seq.push(@seq[0]+@seq[1]);
        @seq.shift;
        if (isprime(@seq[*-1])) {
            $out.set(@seq[*-1]);
            if ($out.elems >= $n) {
                last;
            }
        }
    }
    return $out.keys.sort;
}
