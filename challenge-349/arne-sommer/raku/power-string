#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0, :v(:$verbose));

sub grouped ($str, :$verbose)
{
  my @parts = gather
  {
    my $curr;
    my $count = 0;
    
    for $str.comb -> $char
    {
      if $count && $curr ne $char
      {
        take $curr x $count;
	$count = 0;
      }
      $curr = $char;
      $count++;
    }
    take $curr x $count;
  } 

  say ": Grouped '$str' as { @parts.raku }" if $verbose;
  return @parts;
}

say grouped($str, :$verbose)>>.chars.max;
