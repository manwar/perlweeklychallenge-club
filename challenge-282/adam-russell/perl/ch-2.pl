
  
use v5.38;

  
sub count_key_changes{
  my($s) = @_;
  my $count = 0;
  my @s = split //, lc $s;
  {
      my $x = shift @s;
      my $y = shift @s;
      $count++ if $x && $y && $x ne $y;
      unshift @s, $y if $y;
      redo if @s;
  }  
  return $count;
}

  
MAIN:{
  say count_key_changes(q/pPeERrLl/);
  say count_key_changes(q/rRr/);
  say count_key_changes(q/GoO/);
}  

