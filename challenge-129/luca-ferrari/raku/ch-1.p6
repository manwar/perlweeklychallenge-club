#!raku


class Node {
    has Node $.left is rw;
    has Node $.right is rw;

    has Int $.value;
    has Int $.level = 0;

    method is-leaf() { ! $!left && ! $!right }

    method find-from-here( Int $needle ) {
        return self if $!value == $needle;

        my $r = $!right.find-from-here( $needle ) if $!right;
        return $r if $r;
        my $l = $!left.find-from-here( $needle ) if $!left;
        return $l if $l;
        return Nil if self.is-leaf;

    }
}


sub MAIN( Int $needle = 6 ) {
    my $level = 1;
    my $root = Node.new( value => 1,
                         left => Node.new( value => 2, level => $level ),
                         right => Node.new( value => 3, level => $level ) );
    $root.right.right = Node.new( value => 4, level => ++$level );
    $level++;
    $root.right.right.right = Node.new( value => 6, level => $level );
    $root.right.right.left = Node.new( value => 5, level => $level );



    my $current = $root.find-from-here( $needle );
    say "Found $needle at distance { $current.level }" if $current;
    say "Not found $needle" if ! $current;
}
