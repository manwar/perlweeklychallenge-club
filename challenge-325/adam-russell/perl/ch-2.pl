
  use v5.40;
  
  sub search_lower{
      my($prices, $price, $lower) = @_;
      if(@{$prices} > 0){
          my $next_price = shift @{$prices};
          search_lower($prices, $price, $lower) unless $next_price <= $price;
          $$lower = $next_price if $next_price <= $price;
      }
  }

  
  sub calculate_lowest_prices{
      my @prices = @_;
      my @lowest = ();
      for my $i (0 .. @prices - 1){
          my $lower = 0;
          search_lower [@prices[$i + 1 .. @prices - 1]], $prices[$i], \$lower;
          push @lowest, $prices[$i] - $lower;
      }
      return @lowest;
  }

  
MAIN:{
  say join q/, /, calculate_lowest_prices 8, 4, 6, 2, 3;
  say join q/, /, calculate_lowest_prices 1, 2, 3, 4, 5;
  say join q/, /, calculate_lowest_prices 7, 1, 1, 5;
}

