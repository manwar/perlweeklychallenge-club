#!/usr/bin/perl
use warnings;
use strict;

{   package Stack;
    use List::Util;

    sub new  { bless [], $_[0] }
    sub push { push @{ $_[0] }, $_[1] }
    sub top  { $_[0][-1] }
    sub min  { List::Util::min(@{ $_[0] }) }
    sub pop  { die "Can't pop empty stack" unless @{ $_[0] }; pop @{ $_[0] } }
}

use Test::More tests => 5;
use Test::Exception;

my $stack = 'Stack'->new;

throws_ok { $stack->pop } qr/Can't pop empty stack/;

$stack->push(2);
$stack->push(-1);
$stack->push(0);
my $zero = $stack->pop;

is $zero, 0, 'Removes 0';
is $stack->top, -1, 'Top';

$stack->push(0);
is $stack->min, -1, 'min';
is_deeply $stack, [2, -1, 0], 'Result';
