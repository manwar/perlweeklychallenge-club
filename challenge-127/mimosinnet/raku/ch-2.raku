# https://perlweeklychallenge.org/blog/perl-weekly-challenge-127

#| Get the last interval and check conflict with previous intervals
sub challenge( @intervals ) {

  my @result;

  while @intervals {
    last if @intervals.elems == 1;  # skip when no previous intervals
    my @last = @intervals.pop.flat; # get last interval @last(a,b)
    for @intervals -> @item {       # check for conflict with previos intervals @item(x,y)
      next if @last[0] > @item[1];  # next if a > y, no conflict
      next if @last[1] < @item[0];  # next if b < x, no conflict
      @result.push: @last;          # push @last as it conflicts with previous intervals
    }
  }
  return @result.unique.sort;       # get unique results
}

multi sub MAIN( @intervals ) {
  say 'Input:  @Intervals = ',@intervals;
  say 'Output:              ',challenge( @intervals ),"\n";
}

multi sub MAIN( 'challenge' ) {

  MAIN( [ (1,4), (3,5), (6,8), (12, 13), ( 3,20) ] );
  MAIN( [ (3,4), (5,7), (6,9), (10, 12), (13,15) ] );

}

multi sub MAIN( 'test' )  is hidden-from-USAGE {
  use Test;

  my @test = (
    [ (1,4), (3,5), (6,8), (12,13), ( 3,20) ], [ (3,5), ( 3,20) ],
    [ (3,4), (5,7), (6,9), (10,12), (13,15) ], [ (6,9)          ],
    [ (3,4), (5,7), (6,9), (10,14), (13,15) ], [ (6,9), (13,15) ],
    [ (3,4), (8,9), (5,7), (12,13), ( 6, 7) ], [ (6,7)          ]
  );

  for @test -> $a, $b {
    is challenge($a), $b;
  }

  done-testing;

}
