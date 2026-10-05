#! /usr/bin/env raku

unit sub MAIN (UInt $n, :v(:$verbose));

my $count = 0;

for 2 .. $n.sqrt.Int -> $m
{
  for 1 ..^ $m -> $p
  {
    next unless gcd($m, $p) == 1;
    next unless ($m - $p) % 2;

    my $c = $m**2 + $p**2;
    next unless $c <= $n;

    my $a = $m**2 - $p**2;
    my $b = 2 * $m * $p;
    my $k = $n div $c;

    if $verbose
    {
      for 1 .. $k -> $i
      {
        say ": ({$a * $i}, {$b * $i}, {$c * $i}) & ({$b * $i}, {$a * $i}, {$c * $i}) [i:$i]";
      }
    }

    $count += 2 * $k;
  }
}

say $count;

sub gcd(Int $a is copy, Int $b is copy)
{
  while $b
  {
    ($a, $b) = ($b, $a % $b);
  }
  $a;
}