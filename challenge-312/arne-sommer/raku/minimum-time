#! /usr/bin/env raku

unit sub MAIN (Str $str where $str ~~ /^<[a..z]>+$/, :v(:$verbose));

my @chars = $str.comb;
my $prev  = 'a';
my $time  = 0;

while @chars.elems
{
  my $current = @chars.shift;
  my $diff    = abs( ord($prev) - ord($current) );

  if $diff > 13
  {
    $diff = 26 - $diff;
    say ": $diff sec - Move pointer anti-clockwise from '$prev' to '$current'." if $verbose;
  }
  elsif $diff && $verbose
  {
    say ": $diff sec - Move pointer clocwise from '$prev' to '$current'." ;
  }

  say ": 1 sec - Type the letter '$current'." if $verbose;

  $time += ( $diff + 1 );

  $prev = $current;
}

say $time;
