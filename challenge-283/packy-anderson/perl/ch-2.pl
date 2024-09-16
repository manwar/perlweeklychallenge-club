#!/usr/bin/env perl
use v5.40;

sub digitCountValue(@ints) {
  my %bag;
  grep { $bag{$_}++ } @ints;  # count occurrences
  my @explain;
  my $passes = 1;
  foreach my $digit ( 0 .. $#ints ) {
    my $times  = $ints[$digit];
    my $occurs = $bag{$digit} // 0;
    my $otimes = ($occurs == 0) ? "0 times"
               : ($occurs >= 2) ? "$occurs times"
               :                  "1 time";
    if ($times == $occurs) {
      push @explain,
        "\$ints[$digit] = $times, the digit $digit " .
        "occurs $otimes";
    }
    else {
      $passes = 0;
      my $ttimes = ($times == 0) ? "0 times"
                 : ($times >= 2) ? "$times times"
                 :                 "1 time";      
      push @explain,
        "\$ints[$digit] = $times, the digit $digit " .
        "occurs $otimes rather than $ttimes";
    }
  }
  return $passes ? 'True' : 'False', join("\n", @explain);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my ($passes, $explain) = digitCountValue(@$ints);
  say "Output: $passes\n\n$explain";
}

say "Example 1:";
solution([1, 2, 1, 0]);

say "\nExample 2:";
solution([0, 3, 0]);

say "\nExample 3:";
solution([0, 1, 2, 2]);
