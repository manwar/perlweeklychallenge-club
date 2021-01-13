# Test: perl6 ch-2.p6 3
use v6.d;

class Node {
    has Int $.key is rw;
    has Int $.value is rw;
    has Node $.next is rw;
    has Node $.prev is rw;
}

class LRU {
    has Node $.first is rw;
    has Node $.last is rw;
    has %.positions is rw;
    has Int $.max_capacity is rw;
    has Int $.capacity is rw = 0;

    method set(Int $key, Int $value) {
        my $new_node = Node.new(
            key   => $key,
            value => $value,
            next  => Nil,
            prev  => Nil
        );

        # Push out 1 if at capacity
        if (self.capacity >= self.max_capacity) {
            my $node-to-kill = self.first;
            self.first = self.first.next;
            self.positions.{$node-to-kill.key}:delete;
            self.capacity = self.capacity - 1;
        }

        # Set the first and last reference to the new node
        if ( self.first ) {
            self.last.next = $new_node;
            $new_node.prev = self.last;
        } else {
            self.first = $new_node;
        }

        # Last node
        self.last = $new_node;

        # Store the position
        self.positions.{$key} = $new_node;

        # Increment capacity
        self.capacity = self.capacity + 1;

        say "Setting: ($key, $value)" ~ self.show_nodes;
    }

    method get(Int $key) {
        my $node = self.positions.{$key};

        # Cache miss
        unless ($node) {
            say "Getting: ($key) - cache miss" ~
                self.show_nodes;

            # Return the cache miss -1
            return -1;
        }

        # This might be the first node
        if ($node.prev) {
            $node.prev.next = $node.next;
        } else {
            self.first = $node.next;
        }

        # Change this node previous to last
        $node.prev = self.last;

        # Set the last's next to this node
        self.last.next = $node;

        # clear the node's next as it will be last
        $node.next = Nil;

        # Set to LRU last pointer to this
        self.last = $node;

        # Get the value
        my $value = $node.value;

        say "Getting: ($key) Value: $value)" ~
             self.show_nodes;
        return $node.value;
    }

    method show_nodes() {
        my @keys;
        my $node = self.first;

        while ($node) {
            push @keys, $node.key;
            $node = $node.next;
        }

        return " [LRU] - " ~ @keys.join(',') ~ " - [MRU]";
    }
}

sub MAIN (Int $max_capacity) {
    my $cache = LRU.new( max_capacity => $max_capacity );
    $cache.set(1, 3);
    $cache.set(2, 5);
    $cache.set(3, 7);
    $cache.get(2);      # returns 5
    $cache.get(1);      # returns 3
    $cache.get(4);      # returns -1
    $cache.set(4, 9);
    $cache.get(3);      # returns -1
}
