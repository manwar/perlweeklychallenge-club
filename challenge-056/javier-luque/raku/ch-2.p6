# Test: perl6 ch-2.p6 4
class BTree::Node {
    has Int $.value is rw;
    has BTree::Node $.left is rw;
    has BTree::Node $.right is rw;
}

sub MAIN() {
    my $root =
    	BTree::Node.new(
    		value => 5,
    		left => BTree::Node.new(
    				value => 4,
    				left => BTree::Node.new(
    					value => 11,
    					left => BTree::Node.new(
    						value => 7
    					),
    					right => BTree::Node.new(
    						value => 2,
    					)
    				)
    			),
    		right => BTree::Node.new(
    			value => 8,
    			left => BTree::Node.new(
    				value => 13
    			),
    			right => BTree::Node.new(
    				value => 9,
    				right => BTree::Node.new(
    					value => 1,
    				)
    			)
    		)
    	);

    my $k = 22;
    path-sum($root, $k, 0, '');
}

sub path-sum(BTree::Node $node, Int $k, Int $total is copy, Str $path_string is copy) {
    $total += $node.value;
    $path_string ~= $node.value;

    # Branch left
    path-sum( $node.left,
              $k,
              $total,
              $path_string ~ ' → ' )
    if ($node.left);

    # Branch right
    path-sum($node.right,
             $k,
             $total,
             $path_string ~ ' → ' )
    	if ($node.right);

    # Calculate total if we can't branch
    if ( !$node.left &&
         !$node.right &&
         $total == $k ) {
    	say $path_string;
    }
}
