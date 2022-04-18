#!/usr/bin/env perl

# Challenge 049
#
# TASK #2
# LRU Cache
# Write a script to demonstrate LRU Cache feature. It should support operations
# get and set. Accept the capacity of the LRU Cache as command line argument.
#
# Definition of LRU: An access to an item is defined as a get or a set operation
# of the item. “Least recently used” item is the one with the oldest access time.
#
# For example:
#
# capacity = 3
# set(1, 3)
# set(2, 5)
# set(3, 7)
#
# Cache at this point:
# [Least recently used] 1,2,3 [most recently used]
#
# get(2)      # returns 5
#
# Cache looks like now:
# [Least recently used] 1,3,2 [most recently used]
#
# get(1)      # returns 3
#
# Cache looks like now:
# [Least recently used] 3,2,1 [most recently used]
#
# get(4)      # returns -1
#
# Cache unchanged:
# [Least recently used] 3,2,1 [most recently used]
#
# set(4, 9)
#
# Cache is full, so pushes out key = 3:
# [Least recently used] 2,1,4 [most recently used]
#
# get(3)      # returns -1

use Modern::Perl;
use Test::More;

{
    package Cache;
    use Object::Tiny::RW qw( capacity cache );

    sub new {
        my($class, %args) = @_;
        return bless {cache=>[], %args}, $class;
    }

    sub as_string {
        my($self) = @_;
        my $out = "";
        for (@{$self->cache}) {
            $out .= "(".$_->[0]."=>".$_->[1].")";
        }
        return $out;
    }

    sub get {
        my($self, $k) = @_;
        for my $i (0 .. @{$self->cache}-1) {
            if ($self->cache->[$i][0] == $k) {
                my $v = $self->cache->[$i][1];
                splice(@{$self->cache}, $i, 1);
                push @{$self->cache}, [$k=>$v];
                shift @{$self->cache} while @{$self->cache} > $self->capacity;
                return $v;
            }
        }
        return -1;
    }

    sub set {
        my($self, $k, $v) = @_;
        my $found = $self->get($k);
        if ($found == -1) {
            push @{$self->cache}, [$k=>$v];
            shift @{$self->cache} while @{$self->cache} > $self->capacity;
        }
        else {
            $self->cache->[-1][1] = $v;
        }
    }
}

my $cache = Cache->new(capacity=>3);
is $cache->as_string, "";

$cache->set(1, 3);
is $cache->as_string, "(1=>3)";

$cache->set(2, 5);
is $cache->as_string, "(1=>3)(2=>5)";

$cache->set(3, 7);
is $cache->as_string, "(1=>3)(2=>5)(3=>7)";

is $cache->get(2), 5;
is $cache->as_string, "(1=>3)(3=>7)(2=>5)";

is $cache->get(1), 3;
is $cache->as_string, "(3=>7)(2=>5)(1=>3)";

is $cache->get(4), -1;
is $cache->as_string, "(3=>7)(2=>5)(1=>3)";

$cache->set(4, 9);
is $cache->as_string, "(2=>5)(1=>3)(4=>9)";

is $cache->get(3), -1;
is $cache->as_string, "(2=>5)(1=>3)(4=>9)";

done_testing;
