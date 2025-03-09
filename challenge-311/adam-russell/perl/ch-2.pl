use Data::Dump q/pp/;
  
use v5.38;

  
sub group_digit_sum{
    my($s, $size) = @_;
    my $c = [split //, $s];
    
  my $g = [];
  my $groups;
  for my $i (0 .. @{$c} - 1){
      my $n = $i % $size;
      
      if($n == 0){
          $g = [];
          push @{$g}, $c->[$i];
      }
      elsif($n == $size - 1){
          push @{$g}, $c->[$i];
          push @{$groups}, $g;
          $g = [];
      }
      else{
          push @{$g}, $c->[$i];
      }
  }
  push @{$groups}, $g if @{$g} > 0;

    
  my $sums = [];
  do{
      my $sum = unpack(q/%32I*/, pack(q/I*/, @{$_}));
      push @{$sums}, $sum;
  } for @{$groups};

    
  $s = join q//, @{$sums};
  return $s if length $s <= $size;
  group_digit_sum($s, $size);

  }

  
MAIN:{
  say group_digit_sum q/111122333/, 3;
  say group_digit_sum q/1222312/, 2;
  say group_digit_sum q/100012121001/, 4;
}  

