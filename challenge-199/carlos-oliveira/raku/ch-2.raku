use Test;


sub good-triplets (Int:D @integers, Int:D :$x!, Int:D :$y!, Int:D :$z! --> List:D[Int:D]) {
  my $end = @integers.end;
  my @triplets;
  for (0..$end X 0..$end X 0..$end).grep: { @_[0] < @_[1] < @_[2] } -> ($i, $j, $k) {
    ($x, $y, $z)
      ==> zip (
        abs(@integers[$i] - @integers[$j]),
        abs(@integers[$j] - @integers[$k]),
        abs(@integers[$i] - @integers[$k])
      )
      ==> map({ @_[0] <= @_[1] })
      ==> my @result;
    @triplets.push: (@integers[$i], @integers[$j], @integers[$k]) if all(@result);
  }
  return @triplets;
}


is good-triplets(Array[Int].new(3,0,1,1,9,7), :x(7), :y(2), :z(3)), [<3 0 1>, <3 0 1>, <3 1 1>, <0 1 1>];
is good-triplets(Array[Int].new(1,1,2,2,3),   :x(0), :y(0), :z(1)), [];
