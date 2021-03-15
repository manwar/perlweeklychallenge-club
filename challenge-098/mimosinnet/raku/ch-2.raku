# https://perlweeklychallenge.org/blog/perl-weekly-challenge-098/

sub challenge( @array, $target ) {
  return 0 if  $target < @array[0];
  return @array.elems if $target > @array[*-1];
  return @array.grep(/$target/, :k).Str if $target ∈ @array;
  @array.first: * > $target, :k; 
}

multi sub MAIN( @array, $target ) {
  say 'Input: @N = ' ~ @array.raku ~ ' and $N = ' ~ $target;
  say 'Output: ' ~ challenge(@array, $target), "\n";
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    (
      (1, 2, 3, 4), 3
    ),
    (
      (1, 3, 5, 7), 6
    ),
    (
      (12, 14, 16, 18),10
    ),
    (
      (11, 13, 15, 17), 19
    )
  );
  for @challenge -> [ @array, $target ] {
    MAIN( @array, $target);
  }
}

multi sub MAIN( 't' ) {
  MAIN( 
    (1, 3, 5, 7), 6
  );
}

multi sub MAIN( 'test' ) {
  use Test;

  my @tests = (
    (
      ((1, 2, 3, 4), 3),2
    ),
    (
      ((1, 3, 5, 7), 6),3
    ),
    (
      ((12, 14, 16, 18),10),0
    ),
    (
      ((11, 13, 15, 17), 19),4
    )
  );

  for @tests -> [@a, $b] {
    is challenge(@a[0],@a[1]), $b;
  }

}
