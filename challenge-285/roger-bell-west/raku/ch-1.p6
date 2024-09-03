#! /usr/bin/raku

use Test;

plan 2;

is(noconnection([['B', 'C'], ['D', 'B'], ['C', 'A']]), 'A', 'example 1');
is(noconnection([['A', 'Z'], ]), 'Z', 'example 2');

sub noconnection(@a) {
    my %os = Set.new(@a.map({$_[0]}));
    my %is = Set.new(@a.map({$_[1]}));
    (%is (-) %os)[0]
}
