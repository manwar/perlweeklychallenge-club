#!/usr/bin/raku

class ListNode {
    has Int $.value is required;
    has ListNode $.next is rw;
}

class LinkedList {
    has ListNode $!head;
    has ListNode $!tail;

    submethod BUILD(:@digits = []) {
        for @digits -> $digit {
            self.append($digit);
        }
    }

    method append(Int $value) {
        my $node = ListNode.new(value => $value);

        if $!head.defined {
            $!tail.next = $node;
        }
        else {
            $!head = $node;
        }
        $!tail = $node;
    }

    method values() {
        my @values;
        my $node = $!head;

        while $node.defined {
            @values.push($node.value);
            $node = $node.next;
        }

        return @values;
    }

    method add(LinkedList $other) {
        my @left = self.values;
        my @right = $other.values;
        my @result;
        my $carry = 0;

        while @left || @right || $carry {
            my $sum = (@left.pop // 0) + (@right.pop // 0) + $carry;
            $carry = $sum div 10;
            @result.unshift($sum % 10);
        }

        return LinkedList.new(digits => @result);
    }

    method print() {
        say self.values.join(' -> ');
    }
}

class TreeNode {
    has Int $.value;
    has TreeNode $.left is rw;
    has TreeNode $.right is rw;
}

sub makeTree(@values) {
    return Nil if !@values.elems || @values[0] eq q{-};

    my $root = TreeNode.new(value => @values[0].Int);
    my @parents;
    @parents.push($root);
    my $parentIndex = 0;
    my $valueIndex = 1;

    while $parentIndex < @parents.elems && $valueIndex < @values.elems {
        my $parent = @parents[$parentIndex++];

        for 'left', 'right' -> $side {
            last if $valueIndex >= @values.elems;

            my $value = @values[$valueIndex++];
            next if $value eq q{-};

            my $child = TreeNode.new(value => $value.Int);
            if $side eq 'left' {
                $parent.left = $child;
            } else {
                $parent.right = $child;
            }
            @parents.push($child);
        }
    }

    return $root;
}

sub traverse(TreeNode $root, LinkedList $list) {
    unless $root.defined {
        return $list;
    }

    $list.append($root.value.Int);

    traverse($root.left, $list);
    traverse($root.right, $list);

    return $list;
}

sub MAIN(
    Str $tree  #= level-order tree nodes
) {
    traverse(makeTree($tree.words), LinkedList.new).print;
}