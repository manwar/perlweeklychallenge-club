#! /usr/bin/env raku

unit sub MAIN (Str $tree = "1 | 2 3 | * * * 4  | 5 6", Str $node = '6', :a(:$all), :v(:$verbose));

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

    @new-nodes.push(BinaryNode.new(value  => $value.Int,
                                   left   => $left  // Nil,
                                   right  => $right // Nil)); 
  }
}

my $btree = @new-nodes[0];

my @distance;

traverse2($btree, $node, ());

say @distance.join(" ");

sub traverse2 ($current, $target, @path is copy)
{ 
  @path.push: $current.value;

  if $current.value == $target
  {
    say ": Path: { @path.join(" > ") }" if $verbose;
    @distance.push(@path.elems -1);
    return unless $all;
  }
  
  if ($current.left || $current.right)
  {
    traverse2($current.left,  $target, @path) if $current.left;
    traverse2($current.right, $target, @path) if $current.right;
  }
}
