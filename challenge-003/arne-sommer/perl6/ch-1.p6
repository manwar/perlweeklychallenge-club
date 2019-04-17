#! /usr/bin/env perl6

sub MAIN (Int $limit where $limit > 0)
{
  my SetHash $solution = SetHash;

  for 0 .. Inf -> $c
  {
    last if 5 ** $c > $limit;
    
    for 0 .. Inf -> $b
    {
      last if 3 ** $b > $limit;

      for 0 .. Inf -> $a
      {
         my $value = 2 ** $a * 3 ** $b * 5 ** $c;
         last if $value > $limit;
         $solution{$value} = True;
      }
    }
  }
  
  say $solution.keys.sort.join(" ");
}

