#!/usr/bin/env raku
use v6;

sub greatness(@nums, @perm) {
  # determine the "greatness" of a permutation
  # relative to the original array; accepts two
  # arrays to do the comparison
  my $greatness = 0;
  for 0 .. @nums.elems - 1 -> $i {
    $greatness++ if @nums[$i] < @perm[$i];
  }
  return $greatness;
}

sub greatestPermutation(@nums) {
  # first, count up how many of each num we have
  my %num_count;
  for @nums -> $num {
    %num_count{$num}++;
  }

  # now, build a permutation that maximizes "greatness"
  my @perm;
  my @available = %num_count.keys().sort(); # do the sort once
  for @nums -> $num {
    # default to the smallest available number
    my $num_to_add = @available[0];

    AVAIL: for @available -> $avail {
      if ( $avail > $num ) {
        # make this the number we're putting in the permutation
        $num_to_add = $avail;
        last AVAIL;
      }
    }
    @perm.push($num_to_add);

    # decrement the count of that number available
    %num_count{$num_to_add}--;

    # if there are no more of that number, remove it
    # from @available array
    if ( %num_count{$num_to_add} == 0 ) {
      # filter array to not include $num
      @available = @available.grep( { $_ != $num_to_add } );
    }
  }

  return @perm;
}

sub solution(*@nums) {
  say 'Input: @ints = (' ~ @nums.join(', ') ~ ')';
  my @greatest = greatestPermutation(@nums);
  my $greatness = greatness(@nums, @greatest);
  say 'Output: ' ~ $greatness;
  say "\nOne possible permutation: (" ~ @greatest.join(', ') ~ ')';
  say "which returns $greatness greatness as below:";
  for 0 .. @nums.elems - 1 -> $i  {
    say "nums[$i] < perm[$i]" if @nums[$i] < @greatest[$i];
  }
}

say "Example 1:";
solution(1, 3, 5, 2, 1, 3, 1);

say "\nExample 2:";
solution(1, 2, 3, 4);