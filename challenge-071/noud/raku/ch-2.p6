# You are given a singly linked list and a positive integer $N (>0).
#
# Write a script to remove the $Nth node from the end of the linked list and
# print the linked list.
#
# If $N is greater than the size of the linked list then remove the first node
# of the list.
#
# NOTE: Please use pure linked list implementation.
# Example
# Given Linked List: 1 -> 2 -> 3 -> 4 -> 5
# when $N = 1
# Output: 1 -> 2 -> 3 -> 4
# when $N = 2
# Output: 1 -> 2 -> 3 -> 5
# when $N = 3
# Output: 1 -> 2 -> 4 -> 5
# when $N = 4
# Output: 1 -> 3 -> 4 -> 5
# when $N = 5
# Output: 2 -> 3 -> 4 -> 5
# when $N = 6
# Output: 2 -> 3 -> 4 -> 5

class Node {
    has Int $.value is rw;
    has Node $.next is rw;

    method remove($N) {
        if ($N == 0) {
            return self.next;
        }

        my $cur = self;
        my $index = 0;
        while ($cur) {
            if ($index + 1 == $N) {
                $cur.next = $cur.next.next;
                return self;
            }
            $index++;
            $cur = $cur.next;
        }

        return self.next;
    }

    method display() {
        my $cur = self;
        my @values = [];
        while ($cur) {
            @values.push($cur.value);
            $cur = $cur.next;
        }
        @values.join(" -> ").say;
    }
}

my $n = Node.new();
my $cur = $n;
my @values = (0..10).reverse;
while (@values) {
    $cur.value = @values.pop;
    if (@values) {
        $cur.next = Node.new();
        $cur = $cur.next;
    }
}
$n.display();

$n = $n.remove(5);
$n.display;

$n = $n.remove(11);
$n.display;

$n = $n.remove(0);
$n.display;
