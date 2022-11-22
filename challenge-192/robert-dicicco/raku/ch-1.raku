use v6;

#`{

  AUTHOR: Robert DiCicco

  DATE: 2022-11-21

  Challenge 192 Binary Flip ( Raku )



  You are given a positive integer, $n.



  Write a script to find the binary flip.

  Example 1



  Input: $n = 5

  Output: 2



  First find the binary equivalent of the given integer, 101.

  Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.

  So Binary 010 => Decimal 2.

}



my @ns = (5,4,6);



for @ns -> $n {

  my @out = ();

  say "Input: \$n = $n";

  my @binvals = split("",sprintf("%03b", $n) );

  for @binvals[1..3] -> $v {

    $v == 0 ?? @out.push(1) !! @out.push(0);

  }

  my $outj = @out.join;

  my $intval = ":2<$outj>".Int;

  say "Output: $intval\n";

}



#`{

  SAMPLE Output

  raku .\BinaryFlip.rk



  Input: $n = 5

  Output: 2



  Input: $n = 4

  Output: 3



  Input: $n = 6

  Output: 1

}
