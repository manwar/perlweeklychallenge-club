# https://perlweeklychallenge.org/blog/perl-weekly-challenge-111/

my @matrix = (
  ( 1,  2,  3,  5,  7),
  ( 9, 11, 15, 19, 20),
  (23, 24, 25, 29, 31),
  (32, 33, 39, 40, 42),
  (45, 47, 48, 49, 50)
);

#|
sub challenge( Int $integer ) {
  my @list =  @matrix[*;*].Array;
  return 0 if @list.head > $integer;
  return 0 if $integer   > @list.tail;
  sub find_integer ( $integer ) {
    return 0 if @list.elems == 0;
    return 1 if $integer ∈ @list.splice(@list.elems div 2);
    find_integer($integer);
  }
  return find_integer($integer);
}

multi sub MAIN( Int $integer ) {
  say 'Input:  ',$integer;
  say 'Output: ',challenge($integer),"\n";
}

multi sub MAIN( 'challenge' ) {
  MAIN(35);
  MAIN(39);
}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  is challenge( 0),0;
  is challenge( 2),1;
  is challenge( 4),0;
  is challenge(35),0;
  is challenge(39),1;
  is challenge(51),0;

  done-testing;
}
