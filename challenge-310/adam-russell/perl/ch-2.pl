
  
use v5.38;

  
sub sort_odd_even{
    my @i = @_;
    my @odds = map { $i[$_] } grep {$_ % 2 != 0} 0 .. @_ - 1;
    my @evens = map { $i[$_] } grep {$_ % 2 == 0} 0 .. @_ - 1;
    my @odds_sorted = sort {$b <=> $a} @odds;
    my @evens_sorted = sort {$a <=> $b} @evens;
    my @common_elements;
    do { 
        $common_elements[$_] = shift @odds_sorted if $_ % 2 != 0;
        $common_elements[$_] = shift @evens_sorted if $_ % 2 == 0;
    } for 0 .. @_ - 1;
    return @common_elements;
  }

  
MAIN:{
  say join q/, /, sort_odd_even 4, 1, 2, 3;
  say join q/, /, sort_odd_even 3, 1;
  say join q/, /, sort_odd_even 5, 3, 2, 1, 4;
}  

