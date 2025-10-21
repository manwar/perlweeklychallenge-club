#!/usr/bin/env raku

use Test;

my @examples = (
    { input => { arr => [1, 2, 3, 4],    x => 12   }, exp => [1, 2, 4, 6]    },
    { input => { arr => [2, 7, 4],       x => 181  }, exp => [4, 5, 5]       },
    { input => { arr => [9, 9, 9],       x => 1    }, exp => [1, 0, 0, 0]    },
    { input => { arr => [1, 0, 0, 0, 0], x => 9999 }, exp => [1, 9, 9, 9, 9] },
    { input => { arr => [0],             x => 1000 }, exp => [1, 0, 0, 0]    },
);

for @examples -> $example {
    is-deeply([add-to-array-form($example<input><arr>, $example<input><x>)],
              $example<exp>);
}

done-testing;

sub add-to-array-form($arr, $x) { ($arr.join('') + $x).comb».Int }
