# Test: perl6 ch-1.p6
class LinkedList::Node {
    has Int $.value is rw;
    has LinkedList::Node $.next is rw;
}

class LinkedList {
    has LinkedList::Node $.first is rw;

    # Create the list
    method create-list(*@values) {
    	my $prev_node;

    	# Populate the list
    	for @values -> $value {
    		my $node = LinkedList::Node.new(value => $value);

    		# Populate first and next nodes
    		if ($prev_node) {
    			$prev_node.next = $node
    		} else {
    			self.first = $node;
    		}

    		# Next node
    		$prev_node = $node;
    	}
    }

    method partition_list(Int $k) {
    	# Temp variables to store node locations
    	my $k_node_current;
    	my $k_node_first;
    	my $before_node_current;
    	my $before_node_first;
    	my $after_node_current;
    	my $after_node_first;

    	# Loop through the nodes
    	my $node = self.first;
    	while ($node) {
    		if ($node.value == $k) {
    			if ($k_node_current) {
    				$k_node_current.next = $node;
    				$k_node_current = $node;
    			} else {
    				$k_node_first   = $node;
    				$k_node_current = $node;
    			}
    		}

    		# Process the nodex lower than k
    		if ($node.value < $k) {
    			if ($before_node_current) {
    				$before_node_current.next = $node;
    				$before_node_current = $node;
    			} else {
    				$before_node_first   = $node;
    				$before_node_current = $node;
    			}
    		}

    		# Process the nodex higher than k
    		if ($node.value > $k) {
    			if ($after_node_current) {
    				$after_node_current.next = $node;
    				$after_node_current = $node;
    			} else {
    				$after_node_first   = $node;
    				$after_node_current = $node;
    			}
    		}

    		$node = $node.next;
    	}

    	# link the chains
    	self.first = $before_node_first;
    	$before_node_current.next = $k_node_first;
    	$k_node_current.next = $after_node_first;
    	$after_node_current.next = Nil;
    }

    method display-list {
    	my $node = self.first;
    	my @keys;

    	while ($node) {
    		@keys.push($node.value);
    		$node = $node.next;
    	}

    	return @keys.join(" → ");
    }
}


sub MAIN() {
    my $ll = LinkedList.new();
    $ll.create-list(1,4,3,2,5,2);
    say 'Before: ' ~ $ll.display-list;
    $ll.partition_list(3);
    say 'After: ' ~ $ll.display-list;
}
