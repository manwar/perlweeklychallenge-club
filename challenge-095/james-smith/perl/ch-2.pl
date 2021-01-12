#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use lib q(.);
use Stack;

## Look at the Stack module for implementation

#                        return value  stack after op
my $stack = Stack->new;    # $stack    [          ]
$stack->push(2);           # $stack    [ 2        ]
$stack->push(-1);          # $stack    [ 2, -1    ]
$stack->push(0);           # $stack    [ 2, -1, 0 ]
$stack->pop;               # 0         [ 2, -1    ]
is( $stack->top, -1 );     # -1        [ 2, -1    ]
$stack->push(0);           # $stack    [ 2, -1, 0 ]
is( $stack->min, -1 );     # -1        [ 2, -1, 0 ]
$stack->pop;               # 0         [ 2, -1    ]
$stack->pop;               # -1        [ 2        ]
is( $stack->pop, 2 );      # 2         [          ]
is( $stack->top, undef );  # undef     [          ]

done_testing();

