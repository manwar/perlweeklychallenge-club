# Test: perl6 ch-2.p6 4
class BTree {

    my class Node {
    	has Int $.value is rw;
    	has Node $.left is rw;
    	has Node $.right is rw;
    };

    has Node $.root is rw;

    # Create the binary trees
    multi method create-btree($data) {
    	self.root = Node.new;
    	self.create-btree($data, self.root)
    }

    multi method create-btree($data, Node $node) {
    	$node.value = $data.[0];

    	# Left branch
    	if ($data.[1].[0]) {
    		$node.left = Node.new();
    		self.create-btree($data.[1].[0], $node.left);
    	}

    	# Right branch
    	if ($data.[1].[1]) {
    		$node.right = Node.new();
    		self.create-btree($data.[1].[1], $node.right);
    	}
    }

    # Print the tree
    multi method print-tree() {
    	self.print-tree(self.root);
    }

    multi method print-tree(Node $node) {
    	my $left = ($node.left) ??
    		self.print-tree($node.left) !!
    		Nil;

    	my $right = ($node.right) ??
    		self.print-tree($node.right) !!
    		Nil;

    	my $lists = ($left || $right) ??
    	            ' => ' ~ "[ $left, $right ]" !!
    	            '';

    	return $node.value ~ $lists;
    }

    # Invert the tree
    multi method invert-tree() {
    	self.invert-tree(self.root);
    }

    multi method invert-tree(Node $node) {
    	# Branch left
    	self.invert-tree( $node.left )
    		if ($node.left);

    	# Branch right
    	self.invert-tree( $node.right )
    		if ($node.right);

    	# Invert
    	my $temp = $node.left;
    	$node.left = $node.right;
    	$node.right = $temp;
    }
}

# Main program
sub MAIN() {
    my $btree_data = [
    	1 , [
    		[ 2 , [4 , 5] ],
    		[ 3 , [6 , 7] ],
    	]
    ];
    my $btree = BTree.new();
    $btree.create-btree($btree_data);
    say 'Original: ' ~  $btree.print-tree;
    $btree.invert-tree();
    say 'Inverted: ' ~ $btree.print-tree;
}
