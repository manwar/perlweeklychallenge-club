
  
use v5.40; 

  
sub semi_ordered{
    my $i = [@_];
    my $swaps = 0;
    my $j = -1;
    my $n = @{$i};
    do{ 
        $j = $_ if $i->[$_] == 1;
        $n = $_ if $i->[$_] == $n;
    } for 0 .. @{$i} - 1; 
    {
        if($j != 0){
            
  ($i->[$j - 1], $i->[$j]) = ($i->[$j], $i->[$j - 1]);
  $j--;
  $swaps++;

        }
        if($n != @{$i} - 1){
            
  ($i->[$n + 1], $i->[$n]) = ($i->[$n], $i->[$n + 1]);
  $n++;
  $swaps++;

        }
        redo unless $j == 0 && $n == @{$i} - 1;
    }
    return $swaps;
}

  
MAIN:{
  say semi_ordered 2, 1, 4, 3;
  say semi_ordered 2, 4, 1, 3;
  say semi_ordered 1, 3, 2, 4, 5;
}

