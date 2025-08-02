
  
use v5.40; 

  sub minimum_common{
      my($u, $v) = @_;
      
  my %h = ();
  my %h_u = map {$_ => undef} @{$u};
  my %h_v = map {$_ => undef} @{$v};
  my $minimum = -1;
  do{
      $h{$_}++;
  } for (keys %h_u, keys %h_v);
  my @common = grep {$h{$_} > 1} keys %h;
  if(0 < @common){
      $minimum = (sort {$a <=> $b} @common)[0];
  }

      return $minimum;
  }
  
MAIN:{
  say minimum_common [1, 2, 3, 4], [3, 4, 5, 6];
  say minimum_common [1, 2, 3], [2, 4];
  say minimum_common [1, 2, 3, 4], [5, 6, 7, 8];
}

