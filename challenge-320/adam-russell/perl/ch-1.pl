
  
use v5.40; 

  
  sub maximum_count{
      my @numbers = @_;
      
  my $negatives = 0 + grep {$_ < 0} @numbers;

      
  my $positives = 0 + grep {$_ > 0} @numbers;

      return (sort {$b <=> $a} ($positives, $negatives))[0];
  }

  
MAIN:{
  say maximum_count -3, -2, -1, 1, 2, 3;
  say maximum_count -2, -1, 0, 0, 1;
  say maximum_count 1, 2, 3, 4;
}

