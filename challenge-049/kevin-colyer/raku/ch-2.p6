#!perl6 

use Test;

# Task 2 Challenge 049 Solution by kevincolyer
# LRU Cache
# Write a script to demonstrate LRU Cache feature. It should support 
# operations get and set. Accept the capacity of the LRU Cache as 
# command line argument.
# Definition of LRU: An access to an item is defined as a get or 
# a set operation of the item. “Least recently used” item is the 
# one with the oldest access time.

# For example:
# capacity = 3
# set(1, 3)
# set(2, 5)
# set(3, 7)
# Cache at this point:[Least recently used] 1,2,3 [most recently used]
# get(2)      
# returns 5
# Cache looks like now:[Least recently used] 1,3,2 [most recently used]
# get(1)      
# returns 3
# cache looks like now:[least recently used] 3,2,1 [most recently used]
# get(4)      
# returns -1
# cache unchanged:[least recently used] 3,2,1 [most recently used]
# set(4, 9)
# cache is full, so pushes out key = 3: [least recently used] 2,1,4 [most recently used]
# get(3)      
# returns -1

class MRUCache {
    has $.capacity = 3;
    has @!MRUcache;
    has %!store;

    method set(Int $key,$value) {
        # TODO if key exists do we make Most Recently useed on update?
        if %!store{$key}:exists {
            # swap value - key already exisits
            %!store{$key}=$value;
            return;
        }
        # if cache full swap out oldest
        if @!MRUcache.elems == $.capacity {
            %!store{@!MRUcache[0]}:delete;
            @!MRUcache.shift;
        } 
        
        # add new key to store
        @!MRUcache.push($key);
        %!store{$key}=$value;
        return;
    }

    method get(Int $key) {
        # check key is in store
        return -1 unless %!store{$key}:exists;

        # update MRU list
        # search from morst recent to least recent
        for (^$.capacity).reverse -> $i {
            next unless @!MRUcache[$i]==$key;
            # update cache position by cutting out old key
            @!MRUcache.splice($i,1);
            # and pushing in new key in more recent position (end)
            @!MRUcache.push($key);
        }
        
        # return the value of the key
        return %!store{$key};
    }
    
    # just for debugging
    method viewcache() {
        return @!MRUcache;
    }
}


multi MAIN(Int $capacity where * > 0) {
    my $c= MRUCache.new(capacity=>$capacity);
    say "created MRUcache of capacity {$c.capacity}";
}

multi MAIN ('test') {
    my $c= MRUCache.new(capacity=>3);

    $c.set(1,3);
    $c.set(2, 5);
    is $c.viewcache,(1,2),"cache grows correctly";
    $c.set(3, 7);

    is $c.get(2),5,"get item 2";      
    is $c.viewcache,(1,3,2),"peep at cache";
    is $c.get(1),3,"get first item";      
    is $c.viewcache,(3,2,1),"peep at cache 2";
    is $c.get(4),-1,"try to get cache item > capacity";      
    $c.set(4, 9);
    is $c.viewcache,(2,1,4),"peep at cache";
    is $c.get(3),-1,"get item 3 - but no longer in in cache";   
    done-testing;
}
