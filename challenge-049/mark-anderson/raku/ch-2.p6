#!/usr/bin/env perl6

use Adverb::Eject;

class LRU {
    has $.capacity;
    has @!cache;
    has %!hash;

    method set(Int $k, Int $v) {
        if %!hash{$k}:exists {
            self!update($k);
        }

        else {
            if @!cache.elems == $.capacity {
                %!hash{shift @!cache}:delete;
            }
            
            @!cache.push($k);
            %!hash{$k}{"value"} = $v;
            0..@!cache.elems-1 ==> 
                map { %!hash{@!cache[$_]}{"index"} = $_ }; 
        }
    } 

    method get(Int $k) {
        if %!hash{$k}:exists {
            self!update($k);
        }

        return %!hash{$k}{"value"} // -1;
    }

    method !update(Int $k) {
        my $i = %!hash{$k}{"index"};

        unless $i == @!cache.elems - 1 {
            @!cache[$i]:eject;
            @!cache.push($k);
            $i..@!cache.elems-1 ==> 
                map { %!hash{@!cache[$_]}{"index"} = $_ }; 
        }
    }

    method printIt {
        say "[least recently used] {@!cache.join(", ")} [most recently used]\n";
    }
}

sub MAIN(Int $capacity where $capacity > 0) {
    my $lru = LRU.new(capacity => $capacity);

    say "capacity = {$lru.capacity}\n";
 
    "set(1, 3)".say;
    $lru.set(1, 3);

    "set(2, 5)".say;
    $lru.set(2, 5);

    "set(3, 7)".say;
    $lru.set(3, 7);

    $lru.printIt;

    "get(2)".say;
    $lru.get(2).say;

    $lru.printIt;

    "get(1)".say;
    $lru.get(1).say;

    $lru.printIt;

    "get(4)".say;
    $lru.get(4).say;

    $lru.printIt;

    "set(4, 9)".say;
    $lru.set(4, 9);

    $lru.printIt;

    "get(3)".say;
    $lru.get(3).say;

    $lru.printIt;
}
