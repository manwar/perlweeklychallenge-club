# https://perlweeklychallenge.org/blog/perl-weekly-challenge-097/

# 

sub challenge( $binary, $size ) {
  my $split-binary   = BagHash.new: $binary.comb($size);
  my $frequent-value = $split-binary.kxxv.sort.List.tail;
  my @other-values   = $split-binary.kxxv.List.grep({none /$frequent-value/ });
  return @other-values.map( { (":2<$frequent-value>" +^ ":2<$_>").base(2).split('').sum }).sum;
}

multi sub MAIN( Str $binary, Int $size ) {
  say 'Input: $B = "',$binary,'  $S = ',$size;
  say 'Output: ', challenge($binary, $size), "\n";
}

multi sub MAIN( 'challenge' ) {
  MAIN( '101100101', 3);
  MAIN( '10110111' , 4);
  MAIN( '1111000010101100' , 2);
}

multi sub MAIN( 'test' ) {
  use Test;
  is challenge( '101100101', 3), 1;
  is challenge( '10110111' , 4), 2;
  is challenge( '1111000010101100', 2), 8; 
  is challenge( '1111000010101100', 4), 8; 
}
