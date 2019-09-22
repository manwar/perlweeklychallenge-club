#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ uniq };

sub count {
    my %args = @_;
    my $count = 0;
    $count += () = $args{jewels} =~ /$_/g for uniq(split //, $args{stones});
    $count
}

use Test::More tests => 6;

is count(stones => 'a',          jewels => 'b'),         0;
is count(stones => 'a',          jewels => 'ab'),        1;
is count(stones => 'a',          jewels => 'ababa'),     3;
is count(stones => 'aa',         jewels => 'ababa'),     3;
is count(stones => 'aabb',       jewels => 'ababac'),    5;
is count(stones => 'chancellor', jewels => 'chocolate'), 8;



