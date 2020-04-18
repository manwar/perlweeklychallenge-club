#! /usr/bin/env raku

unit sub MAIN (Int :$sum = 22, Str :$tree = "5 | 4 8 | 11 * 13 9 | 7 2 * * * 1", :$verbose);

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

say $btree, "\n" if $verbose;

traverse($btree, $sum, ());

sub traverse ($current, $target-sum, @path is copy)
{
  if ($current.left or $current.right)
  {
    @path.push: $current.value;

    traverse($current.left,  $target-sum, @path) if $current.left;
    traverse($current.right, $target-sum, @path) if $current.right;
  }
  else
  {
    @path.push: $current.value;
    say ": " ~ @path.join(" -> ") if $verbose;
    say @path.join(" -> ") if @path.sum == $target-sum;
    return;
  }
}
