sub challenge( $A, $B ) {
  return 0 if $A.chars ne $B.chars;
  return 0 if ($A.comb Z=> $B.comb).Hash.elems ne ($B.comb Z=> $A.comb).Hash.elems;
  return 1; 
}


multi sub MAIN( Str:D $A, Str:D $B) {
  my $output = challenge($A,$B);
  say 'Input $A = ' ~ $A ~ '; $B = ' ~ $B;
  say "Output: $output \n"
}

multi sub MAIN( 'challenge' ) {
  for [ < abc xyz >, < abb xyy >, < sum add > ] -> [ $A, $B ] {
    &MAIN( $A, $B);
  }
}

multi sub MAIN( 'test' ) {
  use Test;
  
  my @tests = (
    ( < abcd xyz >, 0 ),
    ( < aaa xyz >,  0 ),
    ( < xyz aaa >,  0 ),
    ( < abc xyz >,  1 ),
    ( < abb xyy >,  1 ),
    ( < sum add >,  0 )
  );

  for @tests -> @test {
   is(challenge(@test[0][0], @test[0][1]), @test[1]);
  }
}


