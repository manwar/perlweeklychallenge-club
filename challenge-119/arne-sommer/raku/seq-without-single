#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0);

my $count   = 1;
my $current = 1;

while $count < $N
{
  my @digits  = $current.comb.reverse;
  my $new     = "";
  my $add     = True;
    
  for $current.comb.reverse -> $digit is copy
  {
    if $add
    {
      if $digit <= 2
      {
        $digit++;
        $add = False;
      }
      else
      {
        $digit = 1;
      }
    }
      
    $new = $digit ~ $new;
  }

  $new = "1$new" if $add; 
  $current = $new;

  $count++ unless $current.contains('11');
}

say $current;