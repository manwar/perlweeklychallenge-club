for 1 .. 20 -> $curr      # [1]
{
  if $curr %% 5           # [2]
  {
    $curr %% 3 ?? say 'fizzbuzz' !! say 'buzz';  # [3]
  }
  elsif $curr %% 3        # [4]
  {
    say 'fizz';           # [4]
  }
  else
  {
    say $curr;            # [5]
  }
}
