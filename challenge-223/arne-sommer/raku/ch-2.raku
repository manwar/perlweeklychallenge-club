#! /usr/bin/env raku

unit sub MAIN (*@box where @box.elems > 0 && all(@box) ~~ UInt && all(@box) > 0,
               :v(:$verbose));

my $coins = 0;

while (@box.elems)
{
  my $i = 0;

  if @box.elems > 3
  {
    $i = smallest-index(@box);
  }
  elsif @box.elems == 3
  {
    $i = 1;
  }
  elsif @box.elems == 2
  {
    $i = 1 if @box[1] < @box[0];
  }
  
  print ":Box: @box[] | I:$i" if $verbose;

  my $left  = $i > 0 ?? @box[$i -1] !! 1;
  my $curr  = @box[$i];
  my $right = $i < @box.end ?? @box[$i +1] !! 1;
  my $add   = $left * $curr * $right;

  $coins += $add;

  @box.splice($i,1);

  say " -> box: @box[] | coins: $add | total: $coins" if $verbose;
}

say $coins;

sub smallest-index (@list)
{
  my $index = 0;
  my $val   = @list[0];

  for 1 .. @list.end -> $i
  {
    if @list[$i] < $val
    {
      $index = $i;
      $val   = @list[$i];
    }
  }

  return $index;
}
