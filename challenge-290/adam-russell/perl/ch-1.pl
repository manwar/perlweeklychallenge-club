
  
use v5.40;

  
sub double_exist{
    my(@a) = @_;
    do{ 
        my $i = $_;
        do{
            my $j = $_;
            if($i != $j){
                return 1 if $a[$i] == 2 * $a[$j];
            }
        } for 0 .. @a - 1;
    } for 0 .. @a - 1;
    return 0;
}

  
MAIN:{
  say double_exist 6, 2, 3, 3;
  say double_exist 3, 1, 4, 13;
  say double_exist 2, 1, 4, 2;
}

