#!raku


class Node {
    has Int $.value;
    has Node $.left is rw;
    has Node $.right is rw;

    method is-BST() {
        my $ok-left  = ! $!left  || ( $!left && $!left.value < $!value );
        my $ok-right = ! $!right || ( $!right && $!right.value >= $!value );
        return $ok-left && $ok-right;
    }

    method is-BST-from-here() {
        my $am-I-ok = self.is-BST();
        return False if ! $am-I-ok;

        my $ok-right = True;
        $ok-right = $!right.is-BST-from-here if $!right;
        my $ok-left  = True;
        $ok-left = $!left.is-BST-from-here if $!left;
        return $ok-right && $ok-left;
    }
}

sub MAIN() {
    my $root         = Node.new( value => 8 );
    $root.left       = Node.new( value => 5 );
    $root.left.left  = Node.new( value => 4 );
    $root.left.right = Node.new( value => 6 );
    $root.right      = Node.new( value => 9 );

    "1".say if $root.is-BST-from-here;
}
