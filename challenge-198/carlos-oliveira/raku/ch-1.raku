sub count_max_gaps (+@input) {
  @input ==> sort()
         ==> my @sorted; @sorted
         ==> tail(*-1)
         ==> zip(@sorted)
         ==> map({ @_[1] - @_[0] })
         ==> my @differences;

  my $max_difference = reduce &max, @differences;
  return @differences.grep({ $_ == $max_difference }).elems;
}

say count_max_gaps (2, 5, 8, 1);
say count_max_gaps (3);
say count_max_gaps (3, 5);
say count_max_gaps ();
