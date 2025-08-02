
  
use v5.38;

  
sub element_digit_sum{
    my($integers) = [@_];
    
my $digit_sum = unpack(q/%32I*/, pack(
    q/I*/, map {split //, $_} @{$integers})
);

    
my $element_sum = unpack(q/%32I*/, pack q/I*/, @{$integers});

    return abs($element_sum - $digit_sum)
}

  
MAIN:{
  say element_digit_sum 1, 2, 3, 45;
  say element_digit_sum 1, 12, 3;
  say element_digit_sum 1, 2, 3, 4;
  say element_digit_sum 236, 416, 336, 350;
}

