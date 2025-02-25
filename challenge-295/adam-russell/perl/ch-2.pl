
  
use v5.40; 
use boolean;
use Data::Dump q/pp/;
  
sub jump{
    my($l, $i, $counter, $moves) = @_; 
    my $m = $l->[$i];
    if($i + $m >= @{$l} - 1){
        push @{$moves}, $counter + 1;
    }
    else{
        do{
            jump($l, $i + $_, $counter + 1, $moves);
        } for 1 .. $m;
    }
}

  
sub jump_game{
    my $moves = [];
    jump [@_], 0, 0, $moves;
    return -1 if 0 == @{$moves};
    return (sort {$a <=> $b} @{$moves})[0];
}

  
MAIN:{
  say jump_game 2, 3, 1, 1, 4;
  say jump_game 2, 3, 0, 4;
  say jump_game 2, 0, 0, 4;
}

