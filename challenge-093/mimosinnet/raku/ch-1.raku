=begin comment
Perl Weekly Challenge 093
https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/

Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.

Input: (1,1), (2,2), (3,3)
Output: 3

Input: (1,1), (2,2), (3,1), (1,3), (5,3)
Output: 3

Rationale:
- Calculate and store the slope of each two points in a BagHash.
- The greatest value of the BagHash is the maximum points in a stragiht line

=end comment

class Point {
  has Int $.x;
  has Int $.y;

  method coord {
    return "($.x,$.y) ";
  }
}

#!Calculates the slope of two points
class Slope {
  has Point $.a;
  has Point $.b;

  method slope {
    # vertical line if bx - ax equals 0
    return 'vl' if  ( $!b.x - $!a.x ) eq 0;
    return ( $!b.y - $!a.y ) / ( $!b.x - $!a.x );
  }
}

#|Calculates the slope of the points and saves into BagHash
sub challenge( @points ) {
  my $slopes = BagHash.new;

  sub count_slopes( @points ) {
    my $point = @points.shift;
    @points.map(-> $i { $slopes.add: Slope.new( a => $point, b => $i ).slope } );
    count_slopes( @points ) if @points.elems gt 1;
  }

  count_slopes( @points );
  # the number of equal slopes gives the number of points in a straight line
  return $slopes.values.sort.Array.pop;
}

multi sub MAIN( @points ) {
  print "\n Input: ";
  @points.map: { .coord.print };
  my $slopes = challenge(@points);
  say "\nOutput: $slopes";
}

multi sub MAIN( 'challenge' ) {
  my @example1 = ( 
    Point.new( x => 1, y => 1 );
    Point.new( x => 2, y => 2 );
    Point.new( x => 3, y => 3 );
  );
  my @example2 = (
    Point.new( x => 1, y => 1 );
    Point.new( x => 2, y => 2 );
    Point.new( x => 3, y => 1 );
    Point.new( x => 1, y => 3 );
    Point.new( x => 5, y => 3 );
  );

  &MAIN(@example1);
  &MAIN(@example2);
}

multi sub MAIN( 'test' ) {
  use Test;
 
  my @example1 = ( 
    Point.new( x => 1, y => 1 );
    Point.new( x => 2, y => 2 );
    Point.new( x => 3, y => 3 );
  );
  my @example2 = (
    Point.new( x => 1, y => 1 );
    Point.new( x => 2, y => 2 );
    Point.new( x => 3, y => 1 );
    Point.new( x => 1, y => 3 );
    Point.new( x => 5, y => 3 );
  );

  my @tests = (
    ( @example1, 3 ),
    ( @example2, 3 )
  );

  for @tests -> @test {
    is(challenge(@test[0]), @test[1]);
  }
}
