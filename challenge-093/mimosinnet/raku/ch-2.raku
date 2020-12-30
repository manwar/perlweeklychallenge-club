=begin comment
Perl Weekly Challenge 093
https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/

You are given binary tree containing numbers 0-9 only.

Write a script to sum all possible paths from root to leaf.

This implementation represents the binary tree with 'lines of nodes', with 0 if the node is empty. Example:

Levels                   line content
  1           1          1
           /     \        
  2       2       3      2 3
         / \     / \
  3     4   0   5   6    4 0 5 6
        1   2   3   4    each node has a position
                         each position has a path, 0 = no path. 

node in level 3, position 3, equals 5
node in level 1, position 1, equals 1

The representation of the tree is: 1 2 3 4 0 5 6

For the exercise:

Input: 1 2 0 3 4 0 0
Output: 13

Input: 1 2 3 4 0 5 6
Ouptup: 26

=end comment

class Tree {
  has Int @.tree is rw;
  has Int $.levels;
  has     @.lines;

  submethod TWEAK() {
    @!lines   = shift @!tree;
    $!levels = 1;
    while @!tree {
      @!lines.push: @!tree.splice( 0, $!levels.exp(2) );
      $!levels++;
    }
  }

  method line( $level )      { self.lines[$level -1 ].flat      }
  method node( $level, $pos) { self.lines[$level -1 ][$pos -1 ] }
}

sub challenge( @tree ) {
  my $tree      = Tree.new( :tree(@tree) );
  my $level     = $tree.levels;
  my @last_line = $tree.line($level--);
  my %paths;
  my $pos = 0;
  for @last_line -> $node {
    ++$pos;
    next unless $node;
    %paths{$pos}.push: $node;
    sub previous_node($level,$pos) {
      if $pos eq 1 { %paths{$pos}.push: $tree.node($level, $pos)                    } 
      else         { %paths{$pos}.push: $tree.node( $level, log2( $pos ).round(1) ) } 
      previous_node( $level - 1 , $pos ) if $level lt 1;
    }
    previous_node($level,$pos);
    %paths{$pos}.push: $tree.node( 1, 1 );
  }
  return %paths.values.map(*.sum).sum;
}

multi sub MAIN( @tree ) {
  "\nInput: ".print;
  @tree.say;
  "Output:  ". print;
  challenge(@tree).say;
}

multi sub MAIN( 'challenge' ) {
  my @example1 = < 1 2 0 3 4 0 0 >;
  my @example2 = < 1 2 3 4 0 5 6 >;
  &MAIN(@example1);
  &MAIN(@example2);
}

multi sub MAIN( 'test' ) {
  use Test;

  my @example1 = < 1 2 0 3 4 0 0 >;
  my $out1 = 13;

  my @example2 = < 1 2 3 4 0 5 6 >;
  my $out2 = 26;

  my @tests = (
    ( @example1, $out1 ),
    ( @example2, $out2 )
  );

  for @tests -> @test {
   is(challenge(@test[0]), @test[1]);
  }

}
