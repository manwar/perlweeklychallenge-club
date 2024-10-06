
  
use v5.40;

  
sub third_maximum{
    my %h;
    do{ $h{$_} = undef } for @_;
    my @sorted = sort {$b <=> $a} keys %h;
    return $sorted[2] if @sorted >= 3;
    return $sorted[0];
}

  
MAIN:{
  say third_maximum 5, 6, 4, 1;
  say third_maximum 4, 5;
  say third_maximum 1, 2, 2, 3;
}

