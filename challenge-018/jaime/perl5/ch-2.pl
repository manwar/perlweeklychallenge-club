#
# # Challenge #2
#
# Write a script to implement Priority Queue. It is like regular queue
# except each element has a priority associated with it. In a priority
# queue, an element with high priority is served before an element with
# low priority. It should serve the following operations:
#
# 1. is_empty: check whether the queue has no elements.
#
# 2. insert_with_priority: add an element to the queue with an
# associated priority.
#
# 3. pull_highest_priority_element: remove the element from the queue
# that has the highest priority, and return it. If two elements have the
# same priority, then return element added first.

my $queue = {};

sub is_empty {
    return not map { @{$_} } values $queue;
}

sub insert_with_priority {
    my ($priority,$body) = @_;
    $queue->{$priority} = [] unless $queue->{$priority};
    push @{$queue->{$priority}}, $body;
}

sub pull_highest_priority_element {
    for my $priority (reverse sort keys %$queue) {
	return shift @{$queue->{$priority}} if @{$queue->{$priority}};
    }
}
