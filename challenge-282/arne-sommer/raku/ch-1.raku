#! /usr/bin/env raku

unit sub MAIN (UInt $int where $int > 99, :v(:$verbose));

my $matching := gather
{
  my @digits  = $int.comb;
  my $current = @digits.shift;
  my $count   = 1;

  while @digits
  {
    my $next = @digits.shift;

    if $current eq $next
    {
      $count++;
    }
    else
    {
      take $current x $count;
      $current = $next;
      $count = 1;
    }
  }

  take $current if $current;
}

for $matching -> $candidate
{
  say ":Considering candidate '$candidate'" if $verbose;
  if $candidate.chars == 3
  {
    say $candidate;
    exit;
  }
}
    
say -1;