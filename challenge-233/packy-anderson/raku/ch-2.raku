#!/usr/bin/env raku
  
use v6;

use Lingua::Conjunction;

sub solution (*@ints where {$_.all ~~ Int}) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';

  # count how often each integer occurs
  my %counts;
  for @ints -> $int {
    %counts{$int}++;
  }

  # now create a hash of arrays listing which integers
  # occur at what frequencies
  my %frequency;
  for %counts.keys -> $int {
    %frequency{ %counts{$int} }.push($int);
  }

  my @output;
  my $text;
  for %frequency.keys.sort -> $freq {
    my @list = %frequency{$freq}.splice(0, *);
    # get each integer for this frequency in descending order
    for @list.sort.reverse -> $int {
      # we need to put the integer on the list $freq times
      @output.append($int xx $freq);
    }
    # now let's do the English description of the output.
    # have the integers in ascending order in the text,
    # and wrap them in quotes
    @list = @list.sort.map: { "'$_'" };
    if (@list.elems == 1) {
      $text ~= @list[0] ~ " has a frequency of $freq\n";
    }
    else {
      $text ~= conjunction @list;
      if (@list.elems == 2) {
        $text ~= ' both';
      }
      $text ~= " have a frequency of $freq, "
            ~  "so they are sorted in decreasing order\n";
    }
  }

  say "Output: (" ~ @output.join(', ') ~ ")";
  say "\n$text";
}

say "Example 1:";
solution(1,1,2,2,2,3);

say "";
say "Example 2:";
solution(2,3,1,3,2);

say "";
say "Example 3:";
solution(-1,1,-6,4,5,-6,1,4,1);