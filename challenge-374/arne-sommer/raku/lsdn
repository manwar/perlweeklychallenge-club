#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[0..9]>+$/,
	       :v(:$verbose));

sub grouped ($str)
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

my @groups = grouped($str);

say ": Groups: { @groups.join(", ") }" if $verbose;

say @groups>>.Int.max;
