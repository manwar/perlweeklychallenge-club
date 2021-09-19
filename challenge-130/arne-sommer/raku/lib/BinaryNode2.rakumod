unit class BinaryNode2;

has Int        $.value;
has BinaryNode2 $.left;
has BinaryNode2 $.right;

method create ($string)
{
  die "Call on the class only" if self ~~ BinaryNode2:D;
    
  my @btree = $string.split("|")>>.words;

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

      @new-nodes.push(BinaryNode2.new(value  => $value.Int,
                                     left   => $left  // Nil,
                                     right  => $right // Nil)); 
    }
  }

  return @new-nodes[0];
}

method graph
{
  say 'digraph foogrph {';
  say '  node [shape = record,height=.1];';

  do-it(self);

  say '}';

  sub do-it ($current)
  {
    say "  node{ $current.value }[label = \"<left> |<center> { $current.value }|<right> \"];";

    if $current.left.defined
    {
      say "  \"node{ $current.value }\":left -> \"node{ $current.left.value }\":center;";  
      do-it($current.left);
    }

    if $current.right.defined
    {
      say "  \"node{ $current.value }\":right -> \"node{ $current.right.value }\":center;";  
      do-it($current.right);
    }
  }
}

method is-bst(:$verbose)
{
  try
  {
    CATCH
    {
      return False;
    }
    self.min-max(:$verbose);
    
    return True;
  }
}

method min-max(:$verbose)
{
  my ($left_min,  $left_max)  = self.left  ?? self.left.min-max(:$verbose)  !! (self.value, self.value);
  my ($right_min, $right_max) = self.right ?? self.right.min-max(:$verbose) !! (self.value, self.value);

  say ": Node: { self.value } : Left min: $left_min, max: $left_max | Right min: $right_min, max: $right_max" if $verbose;

  die "Not BST" if $left_max > self.value || $right_min < self.value;
  
  return ( min($left_min, $right_min, self.value), max($left_max, $right_max, self.value) );
}
