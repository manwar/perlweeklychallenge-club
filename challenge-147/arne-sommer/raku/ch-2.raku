#! /usr/bin/env raku

unit sub MAIN;

for 2 .. Inf -> $a
{
  for $a -1 ... 1 -> $b
  {
    my $penta-a = pentagonial($a);
    my $penta-b = pentagonial($b);

    if is-pentagonial($penta-a + $penta-b) && is-pentagonial($penta-a - $penta-b)
    {
      say "$penta-b $penta-a";
      exit;
    }
  }
}

sub is-pentagonial ($candidate)
{
  my $check = (1 + (1 + 24 * $candidate).sqrt) / 6;
  return $check.Int == $check;
}

sub pentagonial ($number)
{
  return $number * ( 3 * $number -1) / 2;
}

say "(no match)";
