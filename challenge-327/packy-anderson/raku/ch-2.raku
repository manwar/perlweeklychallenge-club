#!/usr/bin/env raku
use v6;

sub MAD(@ints) {
  my @mad;
  # let's make the biggest int our starting minimum
  my $min = max @ints;
  while (my $x = @ints.shift) {
    for @ints -> $y {
      my $diff = abs($x - $y);
      next if $diff > $min; # too big!
      if ($diff < $min) { # we found a new min!
        $min = $diff; # set the new minimum
        @mad = ();    # clear the old list
      }
      # make sure we put the numbers on the list
      # with the smaller integer first
      @mad.push([sort $x, $y]);
    }
  }
  # and return the list with the pairs sorted as well
  return @mad.sort({ $^a[0] cmp $^b[0] });
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @mad = MAD(@ints);
  # make them printable
  @mad = @mad.map({ qq{[$_[0],$_[1]]} });
  say 'Output: ' ~ @mad.join(', ');
}

say "Example 1:";
solution([4, 1, 2, 3]);

say "\nExample 2:";
solution([1, 3, 7, 11, 15]);

say "\nExample 3:";
solution([1, 5, 3, 8]);
