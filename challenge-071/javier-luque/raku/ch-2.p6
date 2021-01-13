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

	# Remove node
	method remove-node(Int $n is copy) {
		# Loop through the nodes
		my $node = self.first;

		# find total nodes
		my $total = 0;
		while ($node) {
			$node = $node.next;
			$total++;
		}

		# Get the real location
		# relative to the first node
		$n = ($n - 1) % $total;
		$n = $total - $n - 1;

		# Initialize for node removal
		my $i = 0;
		my $last_node;
		$node = self.first;

		# Process each node
		while ($node && $i <= $n) {
			if ($i == $n) {
				# First node
				if ($last_node) {
					$last_node.next = $node.next
				} else {
					self.first = $node.next;
				}

				# Next node
				$node.next = ($node.next) ?? $node.next.next !! Nil;
				last;
			}

			$last_node = $node;
			$node = $node.next;
			$i++;
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
	for (1..6) -> $i {
		my $ll = LinkedList.new();
		$ll.create-list(1,2,3,4,5);
		say 'When $N = ' ~ $i;
		$ll.remove-node($i);
		say 'After: ' ~ $ll.display-list;
	}
}
