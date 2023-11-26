#!/usr/bin/env perl
use v5.38;

use List::Util qw( uniq );

sub findMissing {
  my ($source, $target, $output, $explanation) = @_;

  # convert the target into a hash with each element as keys
  my %targetHash = map { $_ => 1 } @$target;

  # see which elements in the source are not in the target
  my @missing;
  foreach my $elem ( @$source ) {
    if (! exists $targetHash{$elem}) {
      push @missing, $elem;
    }
  }

  # format output explaining what we found
  $$explanation .= "\n(" . join(', ', @$source) . ") has ";
  $$explanation .= scalar(@missing);
  $$explanation .= @missing == 1 ? ' member ' : ' members ';
  if (scalar(@missing) > 0) {
    $$explanation .= '(' . join(', ', @missing) . ') ';
    push @$output, [ uniq @missing ];
  }
  $$explanation .= 'missing from the array ';
  $$explanation .= '(' . join(', ', @$target) . ')';
}

sub findSolution {
  my($arr1, $arr2, $output, $explanation) = @_;
  findMissing($arr1, $arr2, $output, $explanation);
  findMissing($arr2, $arr1, $output, $explanation);
}

sub solution {
  my($arr1, $arr2) = @_;
  say 'Input: @arr1 = (' . join(', ', @$arr1) . ')';
  say '       @arr2 = (' . join(', ', @$arr2) . ')';

  my @output = ();
  my $explanation;
  findSolution($arr1, $arr2, \@output, \$explanation);
  my @formatted_subarray;
  foreach my $subarray ( @output ) {
    push @formatted_subarray, '[' . join(', ', @$subarray) . ']';
  }
  say 'Output: (' . join(', ', @formatted_subarray) . ')';
  say $explanation;
}

say "Example 1:";
solution([1, 2, 3], [2, 4, 6]);

say "Example 2:";
solution([1, 2, 3, 3], [1, 1, 2, 2]);