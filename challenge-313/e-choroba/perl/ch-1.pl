#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub broken_keys($name, $typed) {
    my $rex = join "", map quotemeta . '+', split //, $name;
    return $typed =~ $rex
}

use Test2::V0;
use constant {true  => bool(1),
              false => bool(0)};

plan(4);
is broken_keys('perl', 'perrrl'), true, 'Example 1';
is broken_keys('raku', 'rrakuuuu'), true, 'Example 2';
is broken_keys('python', 'perl'), false, 'Example 3';
is broken_keys('coffeescript', 'cofffeescccript'), true, 'Example 4';
