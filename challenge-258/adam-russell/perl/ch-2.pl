
  
use v5.38;

  
sub count_bits{
  my($x) = @_;
  my $total_count_set_bit = 0;
  while($x){
    my $b = $x & 1;
    $total_count_set_bit++ if $b;
    $x = $x >> 1;
  }
  return $total_count_set_bit;
}

  
sub sum_of_values{
    my $k = shift;
    my(@n) = @_;
    my $sum;
    do{
        $sum += $_[$_] if count_bits($_) == $k;
    } for 0 .. @n - 1;
    return $sum;
}

  
MAIN:{
  say sum_of_values 1, 2, 5, 9, 11, 3;
  say sum_of_values 2, 2, 5, 9, 11, 3;
  say sum_of_values 0, 2, 5, 9, 11, 3;
}

