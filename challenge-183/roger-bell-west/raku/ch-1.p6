#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(uniquearray([[1,2], [3,4], [5,6], [1,2]]),
          [[1,2], [3,4], [5,6]],
          'example 1');
is-deeply(uniquearray([[9,1], [3,7], [2,5], [2,5]]),
          [[9,1], [3,7], [2,5]],
          'example 2');

sub uniquearray(@n) {
    my @o;
    my $oh = SetHash.new;
    for @n -> $i {
        my $ti = $i.raku;
        unless ($oh{$ti}:exists) {
            @o.push($i);
            $oh{$ti} = True;
        }
    }
    return @o;
}
