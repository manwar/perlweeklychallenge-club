# https://perlweeklychallenge.org/blog/perl-weekly-challenge-101/

# This exercise is unfinished. It works for the examples provided,
# but it has issues with complex ones. 

#|
sub challenge( @array ) {

  my $cols = sqrt(@array.elems).ceiling - 1;
  my $rows = sqrt(@array.elems).floor   - 1;
  my @spiral;

  sub array_boundary( $rows, $row is copy, $cols, $col is copy, @array ) {
    my $array_area = 2 * ( $cols + $rows );
    # We start at the highest row, lowest column
    my $col_inc = 1;
    my $row_inc = 0;
    # First value
    @spiral[ $row ][ $col ] = @array.shift;
    for 2..$array_area {
      last unless @array.elems;
      if    $col == $cols and $row == $rows { $col_inc =  0; $row_inc = -1 }
      elsif $col == $cols and $row == 0     { $col_inc = -1; $row_inc =  0 }
      elsif $col == 0     and $row == 0     { $col_inc =  0; $row_inc =  1 }
      $row += $row_inc;
      $col += $col_inc;
      @spiral[ $row ][ $col ] = @array.shift;
    }
    return unless @array.elems;
    array_boundary($rows - 1, $rows -1, $cols - 1, 1, @array); 
  }
  array_boundary($rows, $rows, $cols, 0, @array.Array);
  return @spiral;
}

multi sub MAIN( $a ) {
  say 'Input: @A = (',$a,')';
  say 'Output:';
  for challenge($a) -> @a {
    say @a;
  }
}

multi sub MAIN( 'challenge' ) {
  my @challenge = (
    (1..4),
    (1..6),  
    (1..12)  
  );

  for @challenge -> $a {
    MAIN($a);
  }
}

multi sub MAIN( 'test' ) {
  use Test;

  my @test = (
    (
      (1..4),   
      [[4,3], [1,2]]
    ),
    (
      (1..6),  
      [[6,5,4], [1,2,3]]
    ),
    (
      (1..12),  
      [[9,8,7,6], [10,11,12,5], [1,2,3,4]]
    )
  );

  for @test -> ($a, $b ) {
    is-deeply challenge($a), $b;
  }
 
}
