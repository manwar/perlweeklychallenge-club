use v5.26;
use warnings;

package ListNode {
	use Moo;

	has "value" => (
		is => "ro",
	);

	has "next_node" => (
		is => "ro",
		writer => "set_next_node",
	);
};

sub reorder_list {
	my ($list) = @_;

	my sub make_linked_list {
		my $last = undef;
		foreach my $item (reverse $list->@*) {
			my $node = ListNode->new(value => $item, next_node => $last);
			$last = $node;
		}

		return $last;
	}

	my sub linked_list_to_array {
		my ($head) = @_;

		my @result;
		while (defined $head) {
			push @result, $head->value;
			$head = $head->next_node;
		}

		return \@result;
	}

	my sub detach_tail {
		my ($node) = @_;

		my $last_node;
		while (defined $node->next_node) {
			$last_node = $node;
			$node = $node->next_node;
		}

		return undef unless defined $last_node;

		$last_node->set_next_node(undef);
		return $node;
	}

	my $list_head = make_linked_list;
	my $current = $list_head;

	while (-reordering) {
		my $tail = detach_tail $current;
		if (!defined $current->next_node) {
			if (defined $tail) {
				$current->set_next_node($tail);
			}
			last;
		}

		my $next = $current->next_node;
		$current->set_next_node($tail);
		$tail->set_next_node($next);
		$current = $next;
	}

	return linked_list_to_array($list_head);
}

use Test::More;

is_deeply
	reorder_list([1]),
	[1];

is_deeply
	reorder_list([1, 2]),
	[1, 2];

is_deeply
	reorder_list([1, 2, 3, 4]),
	[1, 4, 2, 3];

is_deeply
	reorder_list([1, 2, 5, 3, 4]),
	[1, 4, 2, 3, 5];

is_deeply
	reorder_list([1, 2, 3, 4, 5, 6]),
	[1, 6, 2, 5, 3, 4];

done_testing;
