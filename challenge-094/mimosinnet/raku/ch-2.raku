=begin comment
Perl Weekly Challenge 094-2 
https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/

You are given a binary tree.

Write a script to represent the given binary tree as an object and flatten it to a linked list object. Finally print the linked list object.

    Input:

        1
       / \
      2   3
     / \
    4   5
       / \
      6   7

    Output:

        1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3

There are different forms of coding the tree. One way is to scan the elmeents using level order, with 0 when the node is not defined, and last zeros not recorded. That will give this representation: 

a) Tree representation: 1 2 3 4 5 0 0 0 0 0 6 7 0 0 0 0

Another approach is to start coding the left of the tree, and continue to the rifht when there are no more left-nodes, with a zero when the node is not define. This will give:

b) Tree representation: 1 2 4 0 0 5 6 7 3

I have unsuccessfull tried to solve the exercise with representation (a). With (b) the solution seems easier, but I nevetheless had to use Luca Ferrary Class definition of Node. 

=end comment

#! Using Luca Ferrary's definition of Class Node
class Node {

  has Int   $.value;  
  has Node  $.left  is rw;
  has Node  $.right is rw;


  method add-left( $value ) {
    $.left = Node.new( value => $value );
  }

  method add-right( $value ) {
    $.right = Node.new( value => $value );
  }

  method tree-flat() {
    my @tree = self.node-value;
    @tree.push: $!left.tree-flat  if $!left;
    @tree.push: $!right.tree-flat if $!right;
    @tree;
  }

  method node-value() { self.value; }
}

#| recursive definition of the tree
sub challenge( @tree ) {
  my $node = Node.new( value => @tree.shift);
  my $pos  = 1; 

  sub add_node( $new_node ) {
    $pos++;
    return $new_node unless @tree.elems;
    my $value = @tree.shift;
    $pos %% 2
      ?? add_node( $new_node.add-left($value)  )
      !! add_node( $new_node.add-right($value) );
  }
 
  add_node( $node );
  # Remove empty nodes and add ' -> '
  return $node.tree-flat().Str.subst( /0 \s+/, '', :g).subst( /\s/, ' -> ', :g);
}

multi sub MAIN( @tree ) {
  say 'Input:  ' ~ @tree;
  say 'Output: ' ~ challenge( @tree );
}

multi sub MAIN( 'challenge' ) {
 MAIN( <  1 2 4 0 0 5 6 7 3 >.Array);
}

multi sub MAIN( 'test' ) {
  use Test;
 
  is(
    challenge(< 1 2 4 0 0 5 6 7 3 >.Array),
    '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3',
  )
}
