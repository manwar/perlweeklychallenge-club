
  
use v5.40; 

  
  sub distinct_average{
      my @numbers = 
  sort {$a <=> $b} @_;

      my %averages;
      
  for my $i (0 .. (@numbers / 2)){
      my($x, $y) = ($numbers[$i], $numbers[@numbers - 1 - $i]);
      $averages{
  sprintf(q/%0.7f/, (($x + $y)/2))
} = undef;
  }

      return 0 + keys %averages;
  }

  
MAIN:{
  say distinct_average 1, 2, 4, 3, 5, 6;
  say distinct_average 0, 2, 4, 8, 3, 5;
  say distinct_average 7, 3, 1, 0, 5, 9;
}

