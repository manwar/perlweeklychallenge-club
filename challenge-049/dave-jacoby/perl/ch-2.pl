#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

my $lru = LRU->new(3);

$lru->set( 1, 3 );
$lru->set( 2, 5 );
$lru->set( 3, 7 );

say join ': ', 1, $lru->get(1);
say join ': ', 2, $lru->get(2);
say join ': ', 3, $lru->get(3);
say join ': ', 4, $lru->get(4);

$lru->list();

$lru->set( 4, 9 );
say $lru->get(1);
$lru->list();
say $lru->get(4);
$lru->list();
$lru->set( 'key', 'val' );
$lru->list();
$lru->dump();

exit;

package LRU;
use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use Carp;
use JSON;

sub new ( $class, $capacity = 3 ) {
    $capacity = int $capacity;
    croak 'Invalid capacity' if $capacity < 1;
    my $self = {};
    $self->{class}    = $class;
    $self->{cache}    = {};
    $self->{order}    = [];
    $self->{capacity} = $capacity;
    $self->{max}      = $capacity - 1;
    return bless $self;
}

sub set ( $self, $key, $value ) {
    my @array = grep { $_ ne $key } $self->{order}->@*;
    unshift @array, $key;
    $#array              = $self->{max} if $#array > $self->{max};
    $self->{order}->@*   = @array;
    $self->{cache}{$key} = $value;

    for my $k ( keys $self->{cache}->%* ) {
        my $f = grep { $_ eq $k } $self->{order}->@*;
        delete $self->{cache}{$k} if $f == 0 ;
    }
    $self->list();
}

sub get ( $self, $key ) {
    my $n = grep { $_ eq $key } $self->{order}->@*;
    my $flag = $n ? 1 : 0;
    return -1 unless $flag;
    my @array = grep { $_ ne $key } $self->{order}->@*;
    unshift @array, $key;
    $#array = $self->{max} if $#array > $self->{max};
    $self->{order}->@* = @array;
    $self->list();
    return $self->{cache}{$key};
}

sub list ($self) {
    say '  LIST:  ' . join ', ', $self->{order}->@*;
}

sub dump ($self) {
    my $json = JSON->new->pretty->canonical;
    say $json->encode(
        {
            cache => $self->{cache},
            order => $self->{order},
        }
    );
}

__DATA__
LRU Cache

Write a script to demonstrate LRU Cache feature. It should support 
operations get and set. Accept the capacity of the LRU Cache as 
command line argument.

    Definition of LRU: An access to an item is defined as a 
    get or a set operation of the item. “Least recently used” 
    item is the one with the oldest access time.

For example:

capacity = 3
set(1, 3)
set(2, 5)
set(3, 7)

Cache at this point:
[Least recently used] 1,2,3 [most recently used]

get(2)      # returns 5

Cache looks like now:
[Least recently used] 1,3,2 [most recently used]

get(1)      # returns 3

Cache looks like now:
[Least recently used] 3,2,1 [most recently used]

get(4)      # returns -1

Cache unchanged:
[Least recently used] 3,2,1 [most recently used]

set(4, 9)

Cache is full, so pushes out key = 3:
[Least recently used] 2,1,4 [most recently used]

get(3)      # returns -1

I found this amazing post talking about LRU Cache.
