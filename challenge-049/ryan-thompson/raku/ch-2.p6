#!/usr/bin/env perl6

# ch-2.p6 - LRU Cache
#
# Ryan Thompson <rjt@cpan.org>

class LRU {
    has UInt $.capacity is required is rw;
    has      %!cache;
    has      $!head;
    has      $!tail;
    has UInt $!length = 0;

    method length() { $!length }

    #| Set item named $key to $val and promote it to head of the list
    method set( $key, $val ) {
        $.evict($key) if $.exists($key);
        
        my $elem = { key => $key, val => $val, next => $!head };
        %!cache{$key} = $elem;
        $!head and $!head<prev> = $elem;
        $!tail //= $elem;
        $!head = $elem;
        $!length++;
        self!expire;

        $val;
    }

    #| Get an item named $key, and promote it.
    method get( $key ) {
        die "$key does not exist" unless $.exists($key);
        my $val = %!cache{$key}<val>;

        $.set($key, $val);
    }

    #| Return true if $key exists
    method exists( $key ) {
        %!cache{$key}:exists;
    }

    #| Evict a specific $key from the cache
    method evict( $key ) {
        die "$key does not exist" unless $.exists($key);
        my $elem = %!cache{$key};

        # Re-link next/prev elements in DLL
        $elem<next> and $elem<next><prev> = $elem<prev>;
        $elem<prev> and $elem<prev><next> = $elem<next>;
        %!cache{$key}:delete;
        $!tail = $elem<prev> if $!tail<key> eq $elem<key>;
        $!head = $elem<next> if $!head<key> eq $elem<key>;

        --$!length;
    }

    #| Returns a list of keys in queue order
    method keys() {
        my @r;
        loop ( my $cur = $!head; $cur; $cur = $cur<next> ) {
            @r.push: $cur<key>;
        }

        @r;
    }

    #| Expire elements off the tail until we are at or below target length
    method !expire() {
        my $len = $.length;
        $.evict( $!tail<key> ) while $.length > $.capacity;
    }


}

use Test;

my LRU $lru;
lives-ok { $lru = LRU.new( :capacity<3> ) };

sub keys_str() { "[" ~ $lru.keys.join(' ') ~ "]" }

is $lru.capacity, 3;


is $lru.length, 0;
is $lru.set(1,3), 3;
is $lru.set(2,5), 5;
is $lru.set(3,7), 7;
is $lru.length, 3;
is keys_str, '[3 2 1]';

is $lru.get(2), 5;
is keys_str, '[2 3 1]';

is $lru.get(1), 3;
is keys_str, '[1 2 3]';

dies-ok { $lru.get(4) };
is keys_str, '[1 2 3]';

is $lru.set(4,9), 9;
is $lru.length, 3;
is keys_str, '[4 1 2]';

dies-ok { $lru.get(3) };

# Test variable capacity

$lru.capacity = 5;
is $lru.length, 3;
is keys_str, '[4 1 2]';
is $lru.set(5, 11), 11;
is keys_str, '[5 4 1 2]';
is $lru.set(6, 13), 13;
is keys_str, '[6 5 4 1 2]';
is $lru.set(7, 15), 15;
is keys_str, '[7 6 5 4 1]';
is $lru.length, 5;

$lru.capacity = 3;
is $lru.length, 5;
is $lru.set(7, 15), 15;
is keys_str, '[7 6 5]';

done-testing;
