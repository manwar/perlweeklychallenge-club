
  use v5.40;
  
  sub calculate_tax{
      my($income, $tax_brackets) = @_;
      
  $tax_brackets = [sort {$a->[0] <=> $b->[0]} @{$tax_brackets}];
  use Data::Dump q/pp/;

      my $tax = 0;
      my $taxed = 0;
      my $taxable = 0;
      
  {
      my $tax_bracket = shift @{$tax_brackets};
      if($tax_bracket->[0] <= $income){
          $taxable = $tax_bracket->[0] - $taxable;
          $tax += ($taxable * ($tax_bracket->[1]/100));
          $taxed += $taxable;
      }
      else{
          $tax += (($income - $taxed) * ($tax_bracket->[1]/100));
          $taxed = $income;
      }
      redo unless $taxed >= $income || @{$tax_brackets} == 0;
  }

      return $tax;
  }

  
MAIN:{
  say calculate_tax 10, [[3, 50], [7, 10], [12,25]];
  say calculate_tax 2, [[1, 0], [4, 25], [5,50]];
  say calculate_tax 0, [[2, 50]];
}

