#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use lib q(.);
use Stack;

my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;
is( $stack->top , -1 );
$stack->push(0);
is( $stack->min, -1 );

done_testing();

