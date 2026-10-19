#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [[3,1,4,2,5], [1,2,4]],   out => [1,4,2]   },
    { in => [[5,4,3,2,1], [1,3,5]],   out => [5,3,1]   },
    { in => [[2,4,1,3], [1,2,3,4]],   out => [2,4,1,3] },
    { in => [[4,1,3,2], [3]],         out => [3]       },
    { in => [[1,3,2,6,5,4], [1,2,3]], out => [1,3,2]   },
);

for @examples -> $ex {
    is-deeply(finishing-order(|$ex<in>), $ex<out>);
}

done-testing;

sub finishing-order(@order, @friends) {
    my %f = @friends.map({ $_ => True });
    return [ @order.grep({ %f{$_} }) ];
}
