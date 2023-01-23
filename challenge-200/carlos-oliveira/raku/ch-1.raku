sub arithmetic-slices (Int:D @integers --> List:D[Int:D]) {
  my @arithmetic-slices;
  for @integers.combinations(3..*) -> @slice {
    @slice  ==> zip(@slice.tail(*-1))
            ==> map({ @_[0] - @_[1] })
            ==> my @diffs;
    @arithmetic-slices.push: @slice if all(@diffs) == @diffs[0];
  }
  return @arithmetic-slices;
}

say arithmetic-slices (my Int @ = (1,2,3,4));
say arithmetic-slices (my Int @ = (2));
