use strict;
use warnings;
use Test::More;

sub find_missing_and_duplicate {
  my @nums = @_;
  my %count;
  my $missing = 0;
  my $duplicate = 0;
  foreach my $num (@nums) {
    $count{$num}++;
    if ($count{$num} > 1) {
      $duplicate = $num;
    }
  }
  for (my $i = 1; $i <= scalar(@nums) + 1; $i++) {
    if (!$count{$i}) {
      $missing = $i;
      last;
    }
  }
  if ($missing && $duplicate) {
    return [$duplicate, $missing];
  } else {
    return -1;
  }
}

# Run the tests

# Test 1: find_missing_and_duplicate returns the correct output for input (1,2,2,4)
is_deeply(find_missing_and_duplicate(1,2,2,4), [2,3], "Test 1 passed");

# Test 2: find_missing_and_duplicate returns the correct output for input (1,2,3,4)
is(find_missing_and_duplicate(1,2,3,4), -1, "Test 2 passed");

# Test 3: find_missing_and_duplicate returns the correct output for input (1,2,3,3)
is_deeply(find_missing_and_duplicate(1,2,3,3), [3,4], "Test 3 passed");

done_testing();

