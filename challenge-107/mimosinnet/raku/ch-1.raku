# https://perlweeklychallenge.org/blog/perl-weekly-challenge-107/

# raku ch-1.raku challenge

# is $sdn a self-descriptive-number?
sub prefix:<Δ>( Int $sdn ) {
  # the last digit of the self-descriptive number must be 0
  $sdn ~~ /0$/ &&
  # self-descriptive numbers have digit sums equal to their base
  $sdn.chars == $sdn.split('').sum && 
  # formal definition
  [and] (0..^$sdn.chars).map({ $sdn.comb[$_] == $sdn.indices($_).elems });
}

# get first $elems self-descriptive-numbers. Defaults to 3. 
sub challenge( Int $elems = 3 ) {
  my @numbers;
  # There are no self-descriptive numbers in bases 1, 2, 3
  for 1000..^Inf {
    @numbers.push( $_ ) if  Δ$_;
    return @numbers if @numbers.elems == $elems; 
  }
}

# This is from Mark Anderson! Neat! 
sub challenge1( Int $elems = 3 ) {
  (1..^Inf).grep({ Δ$_ }).head($elems)
}

multi sub MAIN( Int $elems ) {
  say "Write a script to display the first $elems self-descriptive numbers: ";
  say 'Output: ',challenge1($elems).Str;
}

multi sub MAIN( 'challenge' ) {
  MAIN(3);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge(),(1210, 2020, 21200);
  is challenge1(),(1210, 2020, 21200);
}
