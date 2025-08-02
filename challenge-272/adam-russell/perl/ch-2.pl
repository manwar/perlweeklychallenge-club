
  
use v5.38;

  
sub string_score{
  my($s) = shift;
  my $score = 0;
  my @s = map {ord $_} split //, $s;
  {
      my $x = shift @s;
      my $y = shift @s;
      $score += abs($x - $y) if $x && $y;
      unshift @s, $y;
      redo if @s > 1;
  }
  return $score;
}

  
MAIN:{
  say string_score q/hello/;
  say string_score q/perl/;
  say string_score q/raku/;
}  

