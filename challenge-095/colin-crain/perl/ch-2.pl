#! /opt/local/bin/perl
#
#       jenga.pl
#
#         TASK #2 › Demo Stack
#         Submitted by: Mohammad S Anwar
#         Write a script to demonstrate Stack operations like below:
#
#             push($n) - add $n to the stack
#             pop() - remove the top element
#             top() - get the top element
#             min() - return the minimum element
#
#         Example:
#
#             my $stack = Stack->new;
#             $stack->push(2);
#             $stack->push(-1);
#             $stack->push(0);
#             $stack->pop;       # removes 0
#             print $stack->top; # prints -1
#             $stack->push(0);
#             print $stack->min; # prints -1
#
#
#       © 2021 colin crain
#
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";


package Node;
use Moo;

    has value => ( is => 'rw' );
    has down  => ( is => 'rw' );

package Stack;
use Moo;

    has last => ( is => 'rw' );

    sub push {
        my ($self, $value) = @_;
        my $node = Node->new( value => $value ,
                              down  => $self->last  );
        $self->last( $node );
    };

    sub pop {
        my $self = shift;
        my $node = $self->last;
        $self->last( $node->down );
        return $node->value;
    }

    sub top {
        my $self = shift;
       return $self->last->value;
    }

    sub min {
        my $self = shift;
        my $node = $self->last;
        my $min  = $node->value;
        while ( defined $node->down ) {
            $min = $node->down->value if $node->down->value < $min;
            $node = $node->down;
        }
        return $min;
    }

package main;

my $stack = Stack->new;
$stack->push( 2 );
$stack->push( -1 );
$stack->push( 0 );
$stack->pop;                # removes 0
say $stack->top;            # prints -1
$stack->push( 0 );
say $stack->min;            # prints -1







