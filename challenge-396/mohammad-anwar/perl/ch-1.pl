#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => [[3,1,4,2,5], [1,2,4]],   out => [1,4,2]   },
    { in => [[5,4,3,2,1], [1,3,5]],   out => [5,3,1]   },
    { in => [[2,4,1,3], [1,2,3,4]],   out => [2,4,1,3] },
    { in => [[4,1,3,2], [3]],         out => [3]       },
    { in => [[1,3,2,6,5,4], [1,2,3]], out => [1,3,2]   },
);

is_deeply finishing_order(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub finishing_order($order, $friends) {
    my %f = map { $_ => 1 } @$friends;
    return [grep {  $f{$_} } @$order];
}
