
  use v5.40;
  
  sub power_set{
      my @a = ();
      for my $i (1 .. 2 ** @_- 1){
          my @digits = ();
          for my $j (0 .. @_ - 1){
              push @digits, $_[$j] if 1 == ($i >> $j & 1);
          }
          push @a, \@digits;
      }
      return @a;
  }

  
  sub calculate_total_xor{
      my $total = 0;
      for my $a (power_set @_){
          my $t = 0;
          $t = eval join q/ ^ /, ($t, @{$a});
          $total += $t;
      }
      return $total;
  }

  
MAIN:{
  say calculate_total_xor 1, 3;
  say calculate_total_xor 5, 1, 6;
  say calculate_total_xor 3, 4, 5, 6, 7, 8;
}

