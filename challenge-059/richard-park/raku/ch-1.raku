use v6;
sub LinkedList($k = 4, @array = (2,3,7,4,3,1)) {
  # Returns elements in @array with those less than @k at front
  # Ordering is otherwise retained
  my @splitonk = ($_ if $_ < $k for @array);
  @splitonk.append(($_ if $_ >= $k for @array));
  @splitonk;  # Default (2,3,3,1,7,4)
}

my @linked_list = (1,4,3,2,5,2);
my $k = 3;
say LinkedList();
say LinkedList($k,@linked_list);
