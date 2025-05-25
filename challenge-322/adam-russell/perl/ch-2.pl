
  
use v5.40; 

  
  sub number_larger{
      my($x, $unique) = @_;
      return @{$unique} - grep {$_ > $x} @{$unique};
  }

  
  sub rank_array{
      my(@i) = @_;
      my %h;
      my @unique = ();
      
  do{$h{$_} = undef} for @i;

      @unique = keys %h;
      return map {number_larger $_, [@unique]} @i;
  }

  
MAIN:{
  say q/(/ . join(q/, /, (rank_array 55, 22, 44, 33)) . q/)/;
  say q/(/ . join(q/, /, (rank_array 10, 10, 10)) . q/)/;
  say q/(/ . join(q/, /, (rank_array 5, 1, 1, 4, 3)) . q/)/;
}

