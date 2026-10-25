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
    my $parentIndex = 0;
    my $valueIndex = 1;

    while $parentIndex < @parents.elems && $valueIndex < @values.elems {
        my $parent = @parents[$parentIndex++];

        for 'left', 'right' -> $side {
            last if $valueIndex >= @values.elems;

            my $value = @values[$valueIndex++];
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

sub isBST($root, $minimum, $maximum) {
    unless $root.defined {
        return True;
    }

    my $value = $root.val;

    if $minimum.defined && $value < $minimum {
        return False;
    }

    if $maximum.defined && $value > $maximum {
        return False;
    }

    return isBST($root.left, $minimum, $value)
        && isBST($root.right, $value, $maximum);
}

sub MAIN(
    Str $tree  #= level-order tree nodes
) {
    say isBST(makeTree($tree.words), Nil, Nil) ?? 1 !! 0;
}