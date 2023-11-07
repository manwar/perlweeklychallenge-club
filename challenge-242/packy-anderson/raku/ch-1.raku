#!/usr/bin/env raku
use v6;

use Lingua::Conjunction;

sub findMissing(@source, @target, @output, $explanation is rw) {
  # convert the target into a hash with each element as keys
  my %targetHash = @target.map: * => 1;

  # see which elements in the source are not in the target
  my @missing;
  for @source -> $elem {
    if (%targetHash{$elem}:!exists) {
      @missing.push($elem);
    }
  }

  # format output explaining what we found
  $explanation ~= "\n(" ~ @source.join(', ') ~ ") has ";
  $explanation ~= @missing.elems;
  $explanation ~= conjunction(@missing, :str(' member[|s] '));
  if (@missing.elems > 0) {
    $explanation ~= '(' ~ @missing.join(', ') ~ ') ';
    @output.push(@missing.unique);
  }
  $explanation ~= 'missing from the array ';
  $explanation ~= '(' ~ @target.join(', ') ~ ')';
}

sub findSolution(@arr1, @arr2, @output, $explanation is rw) {
  findMissing(@arr1, @arr2, @output, $explanation);
  findMissing(@arr2, @arr1, @output, $explanation);
}

sub solution(@arr1, @arr2) {
  say 'Input: @arr1 = (' ~ @arr1.join(', ') ~ ')';
  say '       @arr2 = (' ~ @arr2.join(', ') ~ ')';

  my @output = ();
  my $explanation;
  findSolution(@arr1, @arr2, @output, $explanation);
  my @formatted_subarray;
  for @output -> @subarray {
    @formatted_subarray.push('[' ~ @subarray.join(', ') ~ ']');
  }
  say 'Output: (' ~ @formatted_subarray.join(', ') ~ ')';
  say $explanation;
}

say "Example 1:";
solution([1, 2, 3], [2, 4, 6]);

say "Example 2:";
solution([1, 2, 3, 3], [1, 1, 2, 2]);