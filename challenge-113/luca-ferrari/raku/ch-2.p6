#!raku

class Node {
    has Int $.value;

    has  $.left is rw;
    has  $.right is rw;

    method sum() {
        my $sum = $!value;
        $sum += $_.sum if ( $_ ) for ( $!left, $!right );
        return $sum;
    }

    method map( &block ) {
        self.new: value => block( $!value ),
            left => $!left.map( &block ),
            right => $!right.map( &block );
    }

    method say() {
        "{ $!value }".say;
        "\t Left  = { $!left.value }".say if $!left;
        "\t Right = { $!right.value }".say if $!right;

        $!left.say if $!left;
        $!right.say if $!right;
    }

    
}

sub MAIN() {

    my $root = Node.new:
    value => 1
        , left => Node.new( value => 2, left => Node.new( value => 4, left => Node.new( value => 7 ) ) )
        , right => Node.new( value => 3, left => Node.new( value => 5 ), right => Node.new( value => 6 ) );

    $root = $root.map: { $root.sum - $_ if $_  };
    $root.say;
}
