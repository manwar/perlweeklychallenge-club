#!/usr/bin/env perl
use v5.40;

use List::Util qw( max );
use Lingua::EN::Inflexion qw( inflect wordlist );

sub maxFrequency(@ints) {
  my %freq;
  map { $freq{$_}++ } @ints;
  my $maxFreq = max(values %freq);
  my @atMax;
  foreach my $i ( sort keys %freq ) {
    if ($freq{$i} == $maxFreq) {
      push @atMax, $i;
    }
  }
  my $list = wordlist(@atMax);
  my $count = scalar(@atMax);
  my $explain = "<#d:$count>The maximum frequency is $maxFreq.\n"
              . "The <N:element> $list <V:has> "
              . "the maximum frequency.";
  return(
    $maxFreq * $count,
    inflect($explain)
  );
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my ($count, $explain) = maxFrequency(@$ints);
  say "Output: $count\n\n$explain";
}

say "Example 1:";
solution([1, 2, 2, 4, 1, 5]);

say "\nExample 2:";
solution([1, 2, 3, 4, 5]);
