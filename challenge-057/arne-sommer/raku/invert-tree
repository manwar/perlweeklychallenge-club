#! /usr/bin/env raku

unit sub MAIN (Str :$tree = "1 | 2 3 | 4 5 6 7", :$verbose, :$quotes);

class BinaryNode
{
  has Int        $.value;
  has BinaryNode $.left   is rw;
  has BinaryNode $.right  is rw;

  method swap
  {
    (self.left, self.right) = (self.right, self.left);
  }
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

traverse($btree);

say $btree, "\n" if $verbose;

say $quotes
  ?? '"' ~ tree2string($btree) ~ '"'
  !!       tree2string($btree);

sub traverse ($current)
{
  $current.swap;

  traverse($current.left)  if $current.left.defined;
  traverse($current.right) if $current.right.defined;
}

sub tree2string ($tree)
{
  my @level;
  my $level = 0;
  
  sub do-it($current, $level)
  {
    say ":: " ~ $current.value if $verbose;
    @level[$level].push($current.value);
    do-it($current.left,  $level +1) if $current.left.defined;
    do-it($current.right, $level +1) if $current.right.defined;
  }
  
  do-it($tree, $level);
 
  return @level.join(" | ").join(" ");
}
