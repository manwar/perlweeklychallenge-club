#! /usr/bin/raku

use Test;

plan 3;

is-deeply(commoncharacters(['java', 'javascript', 'julia']), ['j', 'a'], 'example 1');
is-deeply(commoncharacters(['bella', 'label', 'roller']), ['e', 'l', 'l'], 'example 2');
is-deeply(commoncharacters(['cool', 'lock', 'cook']), ['c', 'o'], 'example 3');

sub commoncharacters (@a) {
    my @ac;
    for @a -> $w {
        @ac.push($w.comb.Bag);
    }
    my %vc = BagHash(@ac[0]);
    for @ac.skip(1) -> $aa {
        for keys %vc -> $c {
            if ($aa{$c}:exists) {
                %vc{$c} = min(%vc{$c}, $aa{$c});
            } else {
                %vc{$c}:delete;
            }
        }
    }
    my @out;
    for @a[0].comb -> $c {
        if (%vc{$c}:exists && %vc{$c} > 0) {
            @out.push($c);
            %vc{$c}--;
        }
    }
    return @out;
}
