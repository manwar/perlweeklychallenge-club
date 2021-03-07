# https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/

# The solution is heavily based on Simon-Proctor and Stuart-Little
# It has been a learning experience to read their code. 

#| Is root
sub isRoot ($n --> Bool) {
    (my $m = $n.sqrt) == $m.Int;
}

#| The digital root of a perfect square can only be 1, 4, 7 or 9.
sub digital-root( $number) {
    return $number ∈ (1, 4, 7, 9) if $number < 10;
    digital-root( $number.split('',:skip-empty).sum) 
}

# non-palindromic $number
multi sub isRare ( Int $number where $number == $number.flip       ) returns Bool { False }

# digital root can only take the values 2, 5, 8 or 9.
multi sub isRare ( Int $number where ($number ~~ /^<[1 3 5 7 9]>/) ) returns Bool { False }

# Cache the results of functions
my %isRoot-cache;
my $l1 = Lock.new;
my %digital-root-cache;
my $l2 = Lock.new;
# Check if number isRare
multi sub isRare (Int $number --> Bool ) {
  my $n1 = $number + $number.flip;
  my $n2 = $number - $number.flip;
  return False if $n2 < 0;
  # perfect square can never end in 2, 3, 7 or 8
  return False if $n1 ~~ /<[2 3 5 7 8]>$/;
  return False if $n2 ~~ /<[2 3 5 7 8]>$/;
  # The digital root of a perfect square can only be 1, 4, 7 or 9.
  return False unless $l2.protect({ %digital-root-cache{$n1} //= digital-root($n1) });
  return False unless $l2.protect({ %digital-root-cache{$n2} //= digital-root($n2) });
  return False unless $l1.protect({ %isRoot-cache{$n1} //= isRoot($n1) });
  return False unless $l1.protect({ %isRoot-cache{$n2} //= isRoot($n2) });
  return True;
}

#|
sub challenge( Int $N ) { 
  ((10**($N-1)..^10**$N)).race.grep( -> $number { isRare($number) }) 
}

multi sub MAIN( Int $N ) {
  say $N,' digits: ',challenge($N);
}

multi sub MAIN( 'challenge' ) {
  my @challenge = 2, 6, 9;

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' ) is hidden-from-USAGE {
  use Test;

  my %test = 
    2, 65,
    6, 621770,
    9, 281089082
  ;

  for %test.keys -> $key {
    is challenge($key.Int), %test{$key};
  }
 
}
