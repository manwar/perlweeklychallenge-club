use v6;

class Node {
    has $.value is rw;
    has $.next is rw;
}
class Linkedlist {
    has Node $.head;
    method make-array () {
        my $node = $.head;
        my @array = $node.value;
        while $node.next:defined {
            $node = $node.next;
            push @array, $node.value;
        }
    return @array;
    }
  method gist () {
        my @a = | $.make-array;
        return join ' -> ', @a;
    }
}
sub build-linked-list (@values is copy) {
    my $last = @values[*-1];
    my @nodes;
    my $tail = Node.new( value => $last, next => Nil);
    @nodes[$last] = $tail;
    for @values[1..@values.end].keys.reverse -> $i {
        my $node = Node.new( value => @values[$i],
            next => @nodes[@values[$i+1]]);
        @nodes[@values[$i]] = $node;
    }
    return Linkedlist.new( head => @nodes[@values[0]]);
}

sub MAIN (Int $n) {
    my @start_range = 1..5;
    my $linked_list = build-linked-list @start_range;
    say "Original list: ", $linked_list;
    my @a = $linked_list.make-array;
    my @new_range = @start_range;
    if $n >= @a.elems {
        shift @new_range;
    } else {
        @new_range[@new_range.end - $n +1]:delete;
    }
    @new_range = grep {.defined }, @new_range;
    my $next_linked_list = build-linked-list @new_range;
    say "New linked list: ", $next_linked_list;
}
