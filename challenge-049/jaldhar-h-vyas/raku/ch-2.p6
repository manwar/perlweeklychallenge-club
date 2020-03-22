#!/usr/bin/perl6

class Data::LRUCache {

    has Int @!cache = ();
    has %!index = ();
    has Int $!capacity is required;

    submethod BUILD( :$capacity ) {
        $!capacity = $capacity;
    }

    method get(Int $key where { $_ > 0 }) {
        if ($key != any @!cache) {
            return -1;
        }
        @!cache = @!cache.grep({ $_ != $key });
        @!cache.unshift($key);
        return %!index{$key}
    }

    method set(Int $key, Any $value) {
        if @!cache.elems ~~ $!capacity {
            my $last = @!cache.pop;
            %!index{$last} :delete;
        }
        @!cache.unshift($key);
        %!index{$key} = $value;
    }

    method print() {
        for @!cache -> $e {
            say "$e => ", %!index{$e};
        }
    }
}

my $capacity = @*ARGS[0] // 3;

my $cache = Data::LRUCache.new(capacity => $capacity);
$cache.set(1, 3);
$cache.set(2, 5);
$cache.set(3, 7);
$cache.print;
say $cache.get(2);
$cache.print;
say $cache.get(1);
$cache.print;
say $cache.get(4);
$cache.print;
$cache.set(4, 9);
$cache.print;
say $cache.get(3);
