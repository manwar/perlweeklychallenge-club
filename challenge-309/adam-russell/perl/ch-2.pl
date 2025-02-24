
  
use v5.38;

  
sub min_diff{
    my $min_gap = 0 + q/inf/;
    my @i = sort {$a <=> $b} @_;
    {
        my $x = shift @i;
        my $y = shift @i;
        if($x && $y){
            my $gap = $y - $x;
            $min_gap = $gap if $gap < $min_gap; 
        }
        unshift @i, $y;
        redo if @i > 1;
    }
    return $min_gap;
  }

  
MAIN:{
  say min_diff 1, 5, 8, 9;
  say min_diff 9, 4, 1, 7;
}  

