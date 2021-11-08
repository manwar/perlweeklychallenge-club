#! /usr/bin/env raku

unit sub MAIN (Str $tree = "1 | 2 5 | 3 4 6 7 | * * * * * * 8 10 | 9", :v(:$verbose));

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

# say ": { $btree.raku }" if $verbose;

my %paths;

traverse2($btree, ());

sub traverse2 ($current, @path is copy)
{
  @path.push: $current.value;
  
  if ($current.left or $current.right)
  {
    traverse2($current.left,  @path) if $current.left;
    traverse2($current.right, @path) if $current.right;
  }
  else
  {
    say ": Node: { $current.value } with path: { @path.join(", ") }"  if $verbose;
    %paths{ $current.value } = @path;

    return;
  }
}

my $best = 0;

for %paths.keys.sort -> $from
{
  for %paths.keys.sort -> $to
  {
    next if $from >= $to;

    my @up   = @(%paths{$from});
    my @down = @(%paths{$to});

    say ": Path: ", @up.reverse.join(", "), ", ", @down.join(", "), " (via top)" if $verbose;

    my $top;
    while (@up[0] == @down[0])
    {
      $top = @up[0];
      @up.shift;
      @down.shift;
    }

    my @path2 = (@up.reverse, $top, @down ).flat;

    my $length = @path2.elems -1;

    if $length > $best
    {
      $best = $length;
      say ":       ", @path2.join(", "), " (shortest) length: $length [BEST]" if $verbose;
    }
    else
    {
      say ":       ", @path2.join(", "), " (shortest) length: $length" if $verbose;
    }
  }
}

say $best;
