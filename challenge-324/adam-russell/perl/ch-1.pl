
  use v5.40;
  
  sub create_array{
      my($i, $r, $c) = @_;
      my @a = ();
      for (0 .. $r - 1){
          my $row = [];
          for (0 .. $c - 1){
              push @{$row}, shift @{$i};
          }
          push @a, $row;
      }
      return @a;
  }

  
MAIN:{
    my $s = q//;
    $s .= q/(/;
    do{
        $s.= (q/[/ . join(q/, /, @{$_}) . q/], /);
    } for create_array [1, 2, 3, 4], 2, 2;
    chop $s;
    chop $s;
    $s .= q/)/;
    say $s;
    
    $s = q//;
    $s .= q/(/;
    do{
        $s.= (q/[/ . join(q/, /, @{$_}) . q/], /);
    } for create_array [1, 2, 3], 1, 3;
    chop $s;
    chop $s;
    $s .= q/)/;
    say $s;      

    $s = q//;
    $s .= q/(/;
    do{
        $s.= (q/[/ . join(q/, /, @{$_}) . q/], /);
    } for create_array [1, 2, 3, 4], 4, 1;
    chop $s;
    chop $s;
    $s .= q/)/;
    say $s;  
} 

