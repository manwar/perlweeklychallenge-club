#!raku


class Node {
    has Int $.value  is rw;
    has Node $.left  is rw;
    has Node $.right is rw;


    method me-recursive() {
        my $str = self.me;
        $str ~= ' -> ' ~ $!left.me-recursive  if $!left;
        $str ~= ' -> ' ~ $!right.me-recursive if $!right;
        $str;
    }

    method me() { $!value; }

}


sub MAIN() {
    my $root              = Node.new( value => 1 );
    $root.left            = Node.new( value => 2 );
    $root.right           = Node.new( value => 3 );
    $root.left.left       = Node.new( value => 4 );
    $root.left.right      = Node.new( value => 5 );
    $root.left.right.left = Node.new( value => 6 );
    $root.left.right.right = Node.new( value => 7 );

    $root.me-recursive.say;

}
