
  
use v5.40; 

  use boolean;
  use List::PowerSet q/powerset_lazy/;
  
sub is_square{
    my $matchsticks = [@_];
    
  my $length_sum = unpack(q/%32I*/, pack(q/I*/, @{$matchsticks}));
  return false if 0 != $length_sum % 4;
  my $side_length = $length_sum / 4;

    
  my $counter = 0;
  my $ps_iterator = powerset_lazy(@{$matchsticks});
  while(my $set = $ps_iterator->()){
      my $set_sum = unpack(q/%32I*/, pack(q/I*/, @{$set}));
      $counter++ if $set_sum == $side_length;
      return true if $counter == 4;
  }  
  return false;

}

  
MAIN:{
  say boolean is_square 1, 2, 2, 2, 1;
  say boolean is_square 2, 2, 2, 4;
  say boolean is_square 2, 2, 2, 2, 4;
  say boolean is_square 3, 4, 1, 4, 3, 1;
}

