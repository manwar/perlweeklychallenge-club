#!/usr/bin/raku

class Node {
    has $.val;
    has Node $.left is rw;
    has Node $.right is rw;
}

sub makeTree(@values) {
    return Nil if !@values.elems || @values[0] eq q{-};

    my $root = Node.new(val => @values[0]);
    my @parents;
    @parents.push($root);
    my $parent-index = 0;
    my $value-index = 1;

    while $parent-index < @parents.elems && $value-index < @values.elems {
        my $parent = @parents[$parent-index++];

        for 'left', 'right' -> $side {
            last if $value-index >= @values.elems;

            my $value = @values[$value-index++];
            next if $value eq q{-};

            my $child = Node.new(val => $value);
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

sub distanceToNode($root, Int $val) {
    if !$root {
        return Nil;
    }

    if $root.val == $val {
        return 0;
    }

    if $root.left {
        my $leftDistance = distanceToNode($root.left, $val);
        if defined $leftDistance {
            return $leftDistance + 1;
        }
    }

    if $root.right {
        my $rightDistance = distanceToNode($root.right, $val);
        if defined $rightDistance {
            return $rightDistance + 1;
        }
    }

    return Nil;
}

sub MAIN(
    Int $node, #= node
    Str $tree  #= level-order tree nodes
) {
    say distanceToNode(makeTree($tree.words), $node);
}
