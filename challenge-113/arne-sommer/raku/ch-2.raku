#! /usr/bin/env raku

unit sub MAIN (Str $tree = '1 | 2 3 | 4 * 5 6 | * 7', :v($verbose), :g(:$graph));

class BinaryNode
{
  has Numeric    $.value  is rw;
  has BinaryNode $.left   is rw;
  has BinaryNode $.right  is rw;

  method id
  {
    self.Str ~~ /(\d+)/; return $0.Str;
  }

  method sum
  {
    my $sum = self.value;
    $sum += self.left.sum  if self.left.defined;
    $sum += self.right.sum if self.right.defined;
    return $sum;
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

say ": Sum: { $btree.sum }" if $verbose;

say ": { $btree.raku }\n" if $verbose;

traverse($btree);

say ": { $btree.raku }\n" if $verbose;

graph($btree) if $graph;

sub traverse ($current)
{
  $current.value = $sum - $current.value;

  traverse($current.left)  if $current.left.defined;
  traverse($current.right) if $current.right.defined;
}

sub graph ($graph)
{
  say 'digraph foogrph {';
  say '  node [shape = record,height=.1];';

  do-it($graph);

  say '}';

  sub do-it ($current)
  {
    say "  node{ $current.id }[label = \"<left> |<center> { $current.value }|<right> \"];";

    if $current.left.defined
    {
      say  "  \"node{ $current.id }\":left -> \"node{ $current.left.id }\":center;";  
      do-it($current.left);
    }

    if $current.right.defined
    {
      say  "  \"node{ $current.id }\":right -> \"node{ $current.right.id }\":center;";  
      do-it($current.right);
    }
  }
}
