#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(reversible(99),
          [ 10, 12, 14, 16, 18, 21, 23, 25, 27, 30, 32, 34, 36, 41,
            43, 45, 50, 52, 54, 61, 63, 70, 72, 81, 90 ],
          'example 1');

sub reversible($mx) {
    my @o;
    for (1..$mx) -> $n {
        my Int $t = $n + flip($n);
        my Bool $q = True;
        while ($t > 0) {
            if ($t % 2 == 0) {
                $q = False;
                last;
            }
            $t div= 10;
        }
        if ($q) {
            @o.push($n);
        }
    }
    return @o;
}
