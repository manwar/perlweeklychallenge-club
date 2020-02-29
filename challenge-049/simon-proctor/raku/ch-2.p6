#!/usr/bin/env perl6

use v6.d;

class Cache::LRU {

    has Int $!capacity where * > 0;
    has %!cache = {};
    has @!key-list = [];

    submethod BUILD ( :$capacity ) { $!capacity = $capacity }

    method !freshen ( $key ) {
        @!key-list.unshift($key).=unique;
        if @!key-list.elems > $!capacity {
            %!cache{@!key-list.pop}:delete;
        }
    }

    method current () {
        return @!key-list;
    }

    method get( $key ) {
        if %!cache{$key}:exists {
            self!freshen( $key );
            return %!cache{$key};
        }
        return Any;
    }

    method set( $key, $value ) {
        %!cache{$key} = $value;
        self!freshen( $key );
        return $value;
    }
}

#| Interactive LRU Cache example. Call with cache capacity
sub MAIN (
    Int $capacity where * > 0 #= Cache capacity (must be greater than zero)
) {
    my $cache = Cache::LRU.new( :$capacity );

    my $done = False;

    my multi sub action( "get", $key ) {
        say $cache.get($key) // "Not found";
    };
    my multi sub action( "set", $key, $value ) {
        $cache.set( $key, $value );
        say "Set $key to $value";
    };
    my multi sub action( "keys" ) {
        say "Current Keys : {$cache.current().join(",")}";
    };
    my multi sub action( "quit" ) {
        say "Bye";
        $done = True;
    };
    my multi sub action( *@ ) {
        say "I'm sorry Dave I don't know how to do that.";
        say "Valid options are :\n\tget \{key\}\n\tset \{key\} \{value\}\n\tkeys\n\tquit";
    };
    
    say "Welcome to the cache demo\nValid options are :\n\tget \{key\}\n\tset \{key\} \{value\}\n\tkeys\n\tquit";
    
    while ! $done {
        my @input = ( prompt "What would you like to do? " ).words;
        action( |@input );        
    }
}

