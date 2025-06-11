#! /usr/bin/env raku

unit sub MAIN (*@prices where @prices.elems >= 1 && all(@prices) ~~ UInt,
               :v(:$verbose));

my @final;

for ^@prices.elems -> $i
{
  my $price = @prices[$i];
  my $lower = @prices[$i+1 .. Inf].grep(* <= $price).first;

  if defined $lower
  {
    my $new = $price - $lower;
    
    say ": Price: $price - lower $lower = $new" if $verbose;
    
    @final.push: $new;
  }
  else
  {
    say ": Price: $price -> no lower = $price" if $verbose;

    @final.push: $price;
  }  
}

say @final;