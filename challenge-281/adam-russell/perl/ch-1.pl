
  
use v5.38;

  
sub check_color{
    my($s) = @_;
    my $a = [split //, $s];
       
  my $n = (-1) ** (ord($a->[0]) - ord(q/`/)); 
  my $color_number = $n * ((-1) ** join q//, @{$a}[1 .. @{$a} - 1]);

    return q/true/ if $color_number < 0;
    return q/false/;
}

  
MAIN:{
  say check_color q/d3/;
  say check_color q/g5/;
  say check_color q/e6/;
  say check_color q/b1/;
  say check_color q/b8/;
  say check_color q/h1/;
  say check_color q/h8/;
}

