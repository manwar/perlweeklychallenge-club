#!/usr/bin/env perl
use v5.38;

sub greatness {
  # determine the "greatness" of a permutation
  # relative to the original array; accepts two
  # array references to do the comparison
  my ($nums, $perm) = @_;
  my $greatness = 0;
  foreach my $i ( 0 .. $#$nums ) {
    $greatness++ if $nums->[$i] < $perm->[$i];
  }
  return $greatness;
}


sub greatestPermutation {
  my @nums = @_;
  # first, count up how many of each num we have
  my %num_count;
  foreach my $num ( @nums ) {
    $num_count{$num}++;
  }

  # now, build a permutation that maximizes "greatness"
  my @perm;
  my @available = sort keys %num_count; # do the sort once
  foreach my $num ( @nums ) {
    # default to the smallest available number
    my $num_to_add = $available[0];

    AVAIL: foreach my $avail ( @available ) {
      if ( $avail > $num ) {
        # make this the number we're putting in the permutation
        $num_to_add = $avail;
        last AVAIL;
      }
    }
    push @perm, $num_to_add;

    # decrement the count of that number available
    $num_count{$num_to_add}--;

    # if there are no more of that number, remove it
    # from @available array
    if ( $num_count{$num_to_add} == 0 ) {
      # filter array to not include $num
      @available = grep { $_ != $num_to_add } @available;
    }
  }

  return @perm;
}

sub solution {
  my @nums = @_;
  say 'Input: @ints = (' . join(', ', @nums) . ')';
  my @greatest = greatestPermutation(@nums);
  my $greatness = greatness(\@nums, \@greatest);
  say 'Output: ' . $greatness;
  say "\nOne possible permutation: (" . join(', ', @greatest) . ')';
  say "which returns $greatness greatness as below:";
  foreach my $i ( 0 .. $#nums ) {
    say "nums[$i] < perm[$i]" if $nums[$i] < $greatest[$i];
  }
}

say "Example 1:";
solution(1, 3, 5, 2, 1, 3, 1);

say "\nExample 2:";
solution(1, 2, 3, 4);