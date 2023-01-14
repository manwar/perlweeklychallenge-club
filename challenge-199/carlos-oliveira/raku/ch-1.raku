use Test;


sub good-pairs (Int:D @integers --> List:D[Int:D]) {
  my $list-end = @integers.end;
  my @pairs;
  for (0..$list-end X 0..$list-end).grep: { @_[0] < @_[1] } -> ($i, $j) {
    if @integers[$i] == @integers[$j] {
      @pairs.push: ($i, $j)
    }
  }
  return @pairs;
}


is good-pairs(my Int @ = 1,2,3,1,1,3), [(0, 3), (0, 4), (2, 5), (3, 4)],       'Test 1';
is good-pairs(my Int @ = 1,2,3),       [],                                     'Test 2';
is good-pairs(my Int @ = 1,1,1,1),     [(0,1),(0,2),(0,3),(1,2),(1,3),(2,3)],  'Test 3';
