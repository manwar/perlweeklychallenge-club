use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-06-06
# Challenge 168 Home Primes ( Raku )

use Prime::Factor;

my @results;

sub homeprime( $hp)  {

  my @factors = prime-factors($hp);

  return(@factors.join);

}

my $hp = 8;

my $flag = 1;

@results.push: $hp;

while $flag > 0  {

  my $retval = homeprime($hp);

  if $retval.is-prime {

    @results.push: $retval;

    $flag = 0;

  } else {

    @results.push: $retval;

    $hp = $retval;

  }

}

for @results -> $val {

  print "$val ";

}

say ' ';
