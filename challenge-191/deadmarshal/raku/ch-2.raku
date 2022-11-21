sub is-cute(@arr)
{
  for 1..@arr.elems -> $i
  {
    return False if $i !%% @arr[$i-1] && @arr[$i-1] !%% $i;
  }
  True;
}

sub cute-list($n)
{
  my @permutations = (1..$n).permutations;
  my $count = 0;
  for @permutations
  {
    $count++ if is-cute($_);
  }
  $count;
}

say cute-list(2);

