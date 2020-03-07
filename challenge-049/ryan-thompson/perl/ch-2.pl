#!/usr/bin/env perl
#
# ch-2.pl - LRU Cache
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

package Local::LRU {
    use Carp;

    sub new {
        my $class = shift;
        bless {
            capacity=> 10,
            @_,

            _length => 0,     # Current size

            # Doubly-linked list
            _cache  => { },
            _head   => undef,
            _tail   => undef,
        }, $class;
    }

    # Sets or gets the maximum length (capacity) of the cache
    sub capacity {
        my ($s, $capacity) = @_;
    
        if ($capacity) {
            $s->{capacity} = $capacity;
            $s->_expire;
        }

        $s->{capacity};
    }

    # Return the current length
    sub length { $_[0]->{_length} }

    # Set item named $key to $val, and promote it to the head of the list
    sub set {
        my ($s, $key, $val) = @_;
        $s->evict($key) if $s->exists($key);

        my $elem = { key => $key, val => $val, next => $s->{_head} };
        $s->{_cache}{$key} = $elem;

        $s->{_head} and $s->{_head}{prev} = $elem;
        $s->{_tail} //= $elem;
        $s->{_head} = $elem;
        $s->{_length}++;
        $s->_expire;

        $val;
    }

    # Get an item named $key, or croak
    sub get {
        my ($s, $key) = @_;
        croak "$key does not exist" unless $s->exists($key);
        my $val = $s->{_cache}{$key}{val};
        $s->set($key, $val);
    }

    # Return true if $key exists
    sub exists {
        my ($s, $key) = @_;
        exists $s->{_cache}{$key};
    }

    # Evict a specific $key from the cache
    sub evict {
        my ($s, $key) = @_;
        croak "$key does not exist" unless $s->exists($key);
        my $elem = $s->{_cache}{$key};

        # Re-link next/prev elements in DLL
        $elem->{next} and $elem->{next}{prev} = $elem->{prev};
        $elem->{prev} and $elem->{prev}{next} = $elem->{next};
        delete $s->{_cache}{$key};
        $s->{_tail} = $elem->{prev} if $s->{_tail} == $elem;
        $s->{_head} = $elem->{next} if $s->{_head} == $elem;

       --$s->{_length};
    }

    # Returns a list of keys in queue order
    sub keys {
        my ($s) = @_;

        my @r;
        for ( my $cur = $s->{_head}; $cur; $cur = $cur->{next} ) {
            push @r, $cur->{key};
        }
        @r;
    }

    # Expire elements off the tail until we are at or below target length
    sub _expire {
        my ($s) = @_;
        $s->evict($s->{_tail}{key}) while $s->length > $s->capacity;
    }

}

#
# Test code
#
use Test::More;
use Test::Exception;

my $lru;
lives_ok { $lru = Local::LRU->new(capacity => 3) };
is $lru->capacity, 3;

sub keys_str() { "[" . join(" ", $lru->keys) . "]" }

is $lru->length, 0;
is $lru->set(1,3), 3;
is $lru->set(2,5), 5;
is $lru->set(3,7), 7;
is $lru->length, 3;
is keys_str, '[3 2 1]';

is $lru->get(2), 5;
is keys_str, '[2 3 1]';

is $lru->get(1), 3;
is keys_str, '[1 2 3]';

dies_ok { $lru->get(4) };
is keys_str, '[1 2 3]';

is $lru->set(4,9), 9;
is $lru->length, 3;
is keys_str, '[4 1 2]';

dies_ok { $lru->get(3) };

# Test variable capacity

is $lru->capacity(5), 5;
is $lru->length, 3;
is keys_str, '[4 1 2]';
is $lru->set(5, 11), 11;
is keys_str, '[5 4 1 2]';
is $lru->set(6, 13), 13;
is keys_str, '[6 5 4 1 2]';
is $lru->set(7, 15), 15;
is keys_str, '[7 6 5 4 1]';
is $lru->length, 5;

is $lru->capacity(3), 3;
is $lru->length, 3;
is keys_str, '[7 6 5]';

done_testing;
