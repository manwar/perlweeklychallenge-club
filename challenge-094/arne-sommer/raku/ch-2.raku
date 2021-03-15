#! /usr/bin/env raku

unit sub MAIN (Str $tree = "1 | 2 3 | 4 5 | * * 6 7", :v(:$verbose));

class BinaryNode
{
  has Int        $.value;
  has BinaryNode $.left;
  has BinaryNode $.right;
}

my @btree = $tree.split("|")>>.words;

my @old-nodes;
my @new-nodes;

for @btree.reverse -> $row
{
  my @current = @$row;
  @old-nodes  = @new-nodes;
  @new-nodes  = ();
  
  for @current -> $value
  {
    if $value eq "*"
    {
      @new-nodes.push("*");
      next;
    }

    my $left  = @old-nodes.shift // "*"; $left  = Nil if $left  eq "*";
    my $right = @old-nodes.shift // "*"; $right = Nil if $right eq "*";

    @new-nodes.push(BinaryNode.new(value => $value.Int,
                                   left  => $left  // Nil,
                                   right => $right // Nil)); 
  }
}

my $btree = @new-nodes[0];

say ": { $btree.raku }" if $verbose;

class UnaryNode
{
  has Int       $.value;
  has UnaryNode $.child is rw;

  method show
  {
    print self.value;
    if self.child { print " -> "; self.child.show; }
    else { say ""; }
  }
}

my $linked-list;
my $ll-current;

traverse($btree);

say ": { $linked-list.raku }" if $verbose;

$linked-list.show;

sub traverse ($current)
{ 
  my $node = UnaryNode.new(value => $current.value);

  $linked-list
    ?? ( $ll-current.child = $node )
    !! ( $linked-list      = $node );
    
  $ll-current = $node;

  traverse($current.left)  if $current.left;
  traverse($current.right) if $current.right;
}
