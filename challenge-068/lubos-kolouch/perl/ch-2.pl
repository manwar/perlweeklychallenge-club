#!/usr/bin/env perl
use strict;
use warnings;

# Node definition
sub new_node {
    my ($value) = @_;
    return { value => $value, next => undef };
}

# Insert node to the list
sub insert_node {
    my ($head, $value) = @_;
    my $node = new_node($value);
    $node->{next} = $head;
    return $node;
}

# Reverse list
sub reverse_list {
    my ($head) = @_;
    my $prev = undef;
    while ($head) {
        my $next = $head->{next};
        $head->{next} = $prev;
        $prev = $head;
        $head = $next;
    }
    return $prev;
}

# Merge two lists
sub merge {
    my ($head1, $head2) = @_;
    my $head = new_node(0);  # dummy node
    my $node = $head;
    while ($head1 && $head2) {
        $node->{next} = $head1;
        $head1 = $head1->{next};
        $node = $node->{next};
        $node->{next} = $head2;
        $head2 = $head2->{next};
        $node = $node->{next};
    }
    $node->{next} = $head1 if $head1;
    return $head->{next};
}

# Reorder list
sub reorder_list {
    my ($head) = @_;
    # Find the middle of the list
    my $slow = $head;
    my $fast = $head;
    while ($fast && $fast->{next}) {
        $slow = $slow->{next};
        $fast = $fast->{next}{next};
    }
    # Reverse the second half of the list
    my $head2 = reverse_list($slow->{next});
    $slow->{next} = undef;
    # Merge two lists
    return merge($head, $head2);
}

# Test the function
my $head = undef;
for my $value (reverse 1..4) {
    $head = insert_node($head, $value);
}

$head = reorder_list($head);

# Print the reordered list
my $node = $head;
while ($node) {
    print $node->{value}, " ";
    $node = $node->{next};
}
print "\n";

