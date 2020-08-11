# Test: perl6 ch-2.p6
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

	method reorder-list(Int $k) {
		# Loop through the nodes
		my $node = self.first;

		# Process each node
		while ($node) {
			my $next_node = $node.next;
			my $traverse_node = $node;
			my $last_node = $node;

			# Traverse Linked list
			while ($traverse_node.next) {
				$last_node = $traverse_node;
				$traverse_node = $traverse_node.next;
			}

			# Move the nodes around
			$node.next = $traverse_node;
			if ($next_node && $next_node.next) {
				$traverse_node.next = $next_node;
				$last_node.next = Nil;
			} else {
				$traverse_node.next = Nil;
			}

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
	$ll.create-list(1,2,3,4);
	say 'Before: ' ~ $ll.display-list;
	$ll.reorder-list(3);
	say 'After: ' ~ $ll.display-list;
}
