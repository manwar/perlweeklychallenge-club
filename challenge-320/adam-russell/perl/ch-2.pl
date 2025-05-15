
  
use v5.40; 

  
  sub sum_difference{
      my @numbers = @_;
      
  my @digits;
  do{
      push @digits, split //, $_;
  } for @numbers;
  my $digit_sum = unpack(q/%32I*/, pack(q/I*/, @digits));

      
  my $element_sum = unpack(q/%32I*/, pack(q/I*/, @numbers));

      return abs($digit_sum - $element_sum);
  }

  
MAIN:{
  say sum_difference 1, 23, 4, 5;
  say sum_difference 1, 2, 3, 4, 5;
  say sum_difference 1, 2, 34;
}

