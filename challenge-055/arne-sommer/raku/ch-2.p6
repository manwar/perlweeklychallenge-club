#! /usr/bin/env raku

unit sub MAIN (*@integers where all(@integers) ~~ Int, :$verbose);

for @integers.permutations.unique(:with(&[eqv])) -> @list
{
  say ": Checking @list[]" if $verbose;

  say @list if is-wave(@list);
}

sub is-wave(@list)
{
  my $current = @list[0];
  my $greater = False;
  
  for @list[1 .. *] -> $next
  {
    if $greater
    {
      ($current = $next; return False) if $next < $current;
    }
    else
    {
      ($current = $next; return False) if $next > $current;
    }
    
    $current = $next;
    $greater = ! $greater;
  }
  return True;
}
