#! /usr/bin/env raku

unit sub MAIN (Int $N where $N >= 10, :v(:$verbose));

my $seq := gather
{
  get-val( (), $N);

  sub get-val (@done is copy, $todo is copy)
  {
    for 1 .. $todo.chars -> $size
    {
      my @done2 = @done.clone;
      my $val   = $todo.substr(0, $size);
      my $todo2 = $todo.substr($size);

      next if $val.starts-with('0');

      @done2.push($val);

      say ": Done: @done2[] { $todo2 ?? "Todo: $todo2" !! ""}" if $verbose;

      $todo2.chars
       ?? get-val(@done2, $todo2)
       !! take @done2;
    }
  }
}

for $seq -> @list
{
  if is-consecutive(@list)
  {
    say @list.join(",");
    last;
  }
}

sub is-consecutive (*@list is copy)
{
  my $first = @list.shift;
  return False if $first.starts-with('0');
  my $second;

  while (@list)
  {
    $second = @list.shift;
    return False if $second.starts-with('0');

    return False unless $second == $first + 1;
    $first = $second;
  }
  
  return True;
}
