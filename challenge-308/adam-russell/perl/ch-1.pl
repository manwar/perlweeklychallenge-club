
  
use v5.38;

  
sub min_gap{
    my($min_gap, $element_min_gap) = (0 + q/inf/, 0 + q/inf/);
    {
        my $x = shift @_;
        my $y = shift @_;
        if($x && $y){
            my $gap = $y - $x;
            if($gap < $min_gap){
                $min_gap = $gap;
                $element_min_gap = $y;
            }
        }
        unshift @_, $y;
        redo if @_ > 1;
    }
    return $element_min_gap;
}

  
MAIN:{
  say min_gap 2, 8, 10, 11, 15;
  say min_gap 1, 5, 6, 7, 14;
  say min_gap 8, 20, 25, 28;
}

