use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-06-20
# Challenge 170 Primorial Numbers ( Raku )

my $count = 1;

my $product = 1;

say 1;

for (1..100) -> $x {

  if (is-prime($x)) {

    $product *= $x;

    say $product;

    $count++;

    last if $count == 10;

  }

}
