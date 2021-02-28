# https://perlweeklychallenge.org/blog/perl-weekly-challenge-1001/

# https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/
#   Point P is inside Triangle A, B, C if:
#   Area ABC = Area ABP + Area ACP + Area BCP

class Vertex
{
  has Int $.x;
  has Int $.y;
}

class Triangle
{
  has Vertex $.a;
  has Vertex $.b;
  has Vertex $.c;

  method area() 
  {
    abs(
      $!a.x * ( $!b.y - $!c.y ) +
      $!b.x * ( $!c.y - $!a.y ) +
      $!c.x * ( $!a.y - $!b.y )
    ) / 2;
  }
}

sub challenge( $a, $b, $c, --> Int ) {

  # Vertex
  my $Va = Vertex.new( x => $a[0], y => $a[1] ); 
  my $Vb = Vertex.new( x => $b[0], y => $b[1] ); 
  my $Vc = Vertex.new( x => $c[0], y => $c[1] );
  my $V0 = Vertex.new( x => 0,     y => 0     );

  # Area
  my $Aabc = Triangle.new( a => $Va, b => $Vb, c => $Vc ).area;
  my $Aab0 = Triangle.new( a => $Va, b => $Vb, c => $V0 ).area;
  my $Abc0 = Triangle.new( a => $Vb, b => $Vc, c => $V0 ).area;
  my $Aac0 = Triangle.new( a => $Va, b => $Vc, c => $V0 ).area;

  return ( $Aabc == $Aab0 + $Abc0 + $Aac0 ).Int; 
}

multi sub MAIN( $a, $b, $c ) {
  say 'Input: A=',$a,', B=',$b,' and C=',$c;
  say 'Output:  ',challenge($a, $b, $c),"\n";
}

multi sub MAIN( 'challenge' ) {

  my @challenge = (
    ((0, 1), ( 1, 0), ( 2,  2)),
    ((1, 1), (-1, 1), ( 0, -3)),
    ((0, 1), ( 2, 0), (-6,  0))
  );

  for @challenge -> ($a, $b, $c) {
    MAIN($a,$b,$c);
  }
}

multi sub MAIN( 'test' ) {
  use Test;

  my @test = (
    ((0, 1), ( 1, 0), ( 2,  2), 0),
    ((1, 1), (-1, 1), ( 0, -3), 1),
    ((0, 1), ( 2, 0), (-6,  0), 1)
  );

  for @test -> ($a, $b, $c, $d ) {
    is challenge($a,$b, $c), $d;
  }

}
