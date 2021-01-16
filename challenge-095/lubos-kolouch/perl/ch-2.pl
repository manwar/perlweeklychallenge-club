#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #095
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/
#               Demo Stack
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/13/2021 02:39:16 PM
#===============================================================================

use strict;
use warnings;

{
package Stack;
use Moose;
use List::Util qw/min/;
use Data::Dumper;

    has 'values' => (is => 'rw', isa=>'ArrayRef', default=>sub{ [] });

    sub push {
        my $self = shift;
        my $what = shift;

        unshift @{$self->values}, $what;
    }

    sub pop {
        my $self = shift;
        my $what = shift;

        return shift @{$self->values} if @{$self->values};
        return;
    }


    sub top {
        my $self = shift;

        return ${$self->values}[0] if @{$self->values};
        return;
    }

    sub stack_min {
        my $self = shift;
        
        return min(@{$self->values});
    }
}

no Moose;
use Test::More;

my $stack = Stack->new; 
$stack->push(2);
is($stack->top, 2, '2 on top');

$stack->push(-1);
is($stack->top, -1, '-1 on top');

$stack->push(0);
is($stack->top, 0, '0 on top');

is($stack->pop, 0, 'Remove 0');
is($stack->top, -1, '-1 on top');

$stack->push(0);
is($stack->top, 0, '0 on top');

is($stack->stack_min, -1, '-1 is min');
done_testing();
