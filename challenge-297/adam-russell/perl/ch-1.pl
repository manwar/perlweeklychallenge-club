
  
use v5.40; 

  
  sub contiguous_array{
      my $b = [@_];
      my $max_length = 0;
      
  do{
      my $i = $_;
      do{
          my $j = $_;
          if($i != $j && $i < $j){
              my @s = @{$b}[$i .. $j];
              my $zeroes = grep {$_ == 0} @s;
              my $ones = grep {$_ == 1} @s;
              $max_length = @s if $zeroes == $ones && 
                                   @s > $max_length;
          }
      } for 0 .. @{$b} - 1;
  } for 0 .. @{$b} - 1;

      return $max_length;
  } 

  
MAIN:{
  say contiguous_array 1, 0; 
  say contiguous_array 0, 1, 0; 
  say contiguous_array 0, 0, 0, 0, 0; 
  say contiguous_array 0, 1, 0, 0, 1, 0; 
}

