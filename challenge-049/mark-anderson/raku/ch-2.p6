#!/usr/bin/env perl6

class LRU {
    has $.capacity;
    has @!cache;
    has %!index;
    has %!value;

    method set(Int $k, Int $v) {
        if defined %!index{$k} {
            self!update($k);
        }

        else {
            if (@!cache.elems == $.capacity) {
                %!value{shift @!cache}:delete;
            }
            
            @!cache.push($k);
            %!value{$k} = $v;
            %!index = @!cache.kv.reverse; #this can be improved since all
                                          #indexes don't need to be updated. 
        }
    } 

    method get(Int $k) {
        if defined %!index{$k} {
            self!update($k);
        }

        return %!value{$k} // -1;
    }

    method !update(Int $k) {
        my $i = %!index{$k};

        unless ($i == $.capacity - 1) {
            @!cache = (@!cache[0..$i-1], @!cache[$i+1..*-1], $k).flat;
            %!index = @!cache.kv.reverse; # ditto
        }
    }

    method printIt {
        say "[least recently used] {@!cache.join(", ")} [most recently used]";
        #say "Value = ", %!value;
        #say "Index = ", %!index;
        print "\n";
    }
}

sub MAIN(Int $capacity where $capacity > 0) {
    my $lru = LRU.new(capacity => $capacity);

    say "capacity = {$lru.capacity}\n";
 
    $lru.set(1, 3);

    $lru.set(2, 5);

    $lru.set(3, 7);

    $lru.printIt;

    $lru.get(2).say;

    $lru.printIt;
    
    $lru.get(1).say;

    $lru.printIt;

    $lru.get(4).say;

    $lru.printIt;

    $lru.set(4, 9);

    $lru.printIt;

    $lru.get(3).say;

    $lru.printIt;
}
