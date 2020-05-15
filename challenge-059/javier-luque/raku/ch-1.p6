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

    method partition-list(Int $k) {
    	# Loop through the nodes
    	my $node = self.first;
    	my $passed_k = False;
    	my $prev_node;
    	my $k_node;

    	while ($node) {
    		my $next_node = $node.next;
    		my $moved_node = False;

    		if ($node.value < $k && $passed_k) {
    			my $traverse_node = self.first;
    			while ($traverse_node.next.value < $node.value) {
    				$traverse_node = $traverse_node.next;
    			}
    			$prev_node.next = $node.next;
    			$node.next = $traverse_node.next;
    			$traverse_node.next = $node;
    			$moved_node = True;
    		}

    		# Other k's
    		if ($node.value == $k && $passed_k) {
    			my $temp = $k_node.next;
    			$prev_node.next = $node.next;
    			$k_node.next = $node;
    			$node.next = $temp;
    			$moved_node = True;
    		};

    		# First k encountered
    		if ($node.value == $k && !$passed_k) {
    			$passed_k = 1;
    			$k_node = $node;
    		};

    		# The prev node pointer only changes if we
    		# didn't move the node
    		$prev_node = $node unless ($moved_node);

    		# Next node
    		$node = $next_node;
    	}
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
    $ll.partition-list(3);
    say 'After: ' ~ $ll.display-list;

    say "\nDuplicate k's";
    $ll.create-list(1,4,3,2,5,2,3);
    say 'Before: ' ~ $ll.display-list;
    $ll.partition-list(3);
    say 'After: ' ~ $ll.display-list;
}
