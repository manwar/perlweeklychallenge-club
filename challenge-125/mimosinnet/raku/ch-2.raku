# https://perlweeklychallenge.org/blog/perl-weekly-challenge-125

# I have been following this:
# https://www.geeksforgeeks.org/diameter-of-a-binary-tree/
# and I believe it is only partially implemented. It does not cover
# the situation where the left side or the right side are longer
# without going to through the root node. 

class Node {
  has Int $.value;
  has Node $.left;
  has Node $.right;
}

class Tree {
  has Node $.tree;

  my $lhight = 0;
  my $rhight = 0;

  sub lhight     ($node) { return left-hight( $node )  }
  sub rhight     ($node) { return right-hight( $node ) }
  sub tree-hight ($node) { return lhight($node) + rhight($node) + 1 }

  sub left-hight( $node  ) {
    return $lhight unless $node.left.defined;
    $lhight += 1;
    left-hight( $node.left);
  }

  sub right-hight( $node  ) {
    return $rhight unless $node.right.defined;
    $rhight += 1;
    right-hight( $node.right);
  }

  method diameter { return tree-hight( self.tree) } 
}

my $nodes = Node.new(
  value => 1,
  left  => Node.new( value => 2,
    left  => Node.new(value => 3),
    right => Node.new(value => 4)
  ),
  right => Node.new( value => 5,
    left  => Node.new( value => 6),
    right => Node.new( value => 7,
      left => Node.new( value => 8,
        left  => Node.new( value => 9)
       ),
       right => Node.new(value => 10)
     )
  )
);

multi sub MAIN( ) {
  my $tree = Tree.new( tree => $nodes);
  say "The diameter of the binary tree is ", $tree.diameter;
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is Tree.new( tree => $nodes).diameter, 6;

  done-testing;
}
