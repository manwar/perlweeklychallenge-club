#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use List::Util qw(reduce);

my @examples = (
    { in  => ["Bob hit a ball, the hit BALL flew far after it was hit.", "hit"],
      out => "ball", },
    { in  => ["Apple? apple! Apple, pear, orange, pear, apple, orange.", "apple", "pear"],
      out => "orange" },
    { in  => ["A. a, a! A. B. b. b.", "b"],
      out => "a" },
    { in  => ["Ball.ball,ball:apple!apple.banana", "ball"],
      out => "apple" },
    { in  => ["The dog chased the cat, but the dog was faster than the cat.", "the", "dog"],
      out => "cat" },
);

is most_popular(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub most_popular {
    my ($para, @banned) = @_;

    my %b = map { lc $_ => 1 } @banned;
    my %f;
    $f{$_}++ for grep { !$b{$_} } map { lc } $para =~ /[a-zA-Z]+/g;
    return reduce { $f{$b} > $f{$a} ? $b : $a } keys %f;
}
