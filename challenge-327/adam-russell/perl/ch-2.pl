
  use v5.40;
  
  sub mad_pairs{
      my %mad = ();
      my $mad = ~0;
      for my $i (0 .. @_ - 1){
          for my $j ($i + 1 .. @_ - 1){
              my $d = abs($_[$i] - $_[$j]);
              $mad = $d if $d < $mad;
              push @{$mad{$d}}, [$_[$i], $_[$j]];
          }
      }
      return @{$mad{$mad}};
  }

  
MAIN:{
    my $s = q//;
    do{
        $s .= q/[/ . join(q/, /, @{$_}) . q/], /;
    } for mad_pairs 4, 1, 2, 3;
    chop $s;
    chop $s;
    say $s;
    $s = q//;

    do{
        $s .= q/[/ . join(q/, /, @{$_}) . q/], /;
    } for mad_pairs 1, 3, 7, 11, 15;
    chop $s;
    chop $s;
    say $s;
    $s = q//;
    
    do{
        $s .= q/[/ . join(q/, /, @{$_}) . q/], /;
    } for mad_pairs 1, 5, 3, 8;
    chop $s;
    chop $s;
    say $s;
    $s = q//;
}

