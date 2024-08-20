#!/usr/bin/env raku
use v6;

sub digitCountValue(@ints) {
  my %bag = @ints.Bag;  # count occurrences
  my @explain;
  my $passes = True;
  for 0 .. @ints.end -> $digit {
    my $times  = @ints[$digit];
    my $occurs = %bag{$digit} // 0;
    my $otimes = ($occurs == 0) ?? "0 times"
              !! ($occurs >= 2) ?? "$occurs times"
              !!                   "1 time";
    if ($times == $occurs) {
      @explain.push(
        "\$ints[$digit] = $times, the digit $digit " ~
        "occurs $otimes"
      );
    }
    else {
      $passes = False;
      my $ttimes = ($times == 0) ?? "0 times"
                !! ($times >= 2) ?? "$times times"
                !!                  "1 time";      
      @explain.push(
        "\$ints[$digit] = $times, the digit $digit " ~
        "occurs $otimes rather than $ttimes"
      );
    }
  }
  return $passes, @explain.join("\n");
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($passes, $explain) = digitCountValue(@ints);
  say "Output: $passes\n\n$explain";
}

say "Example 1:";
solution([1, 2, 1, 0]);

say "\nExample 2:";
solution([0, 3, 0]);

say "\nExample 3:";
solution([0, 1, 2, 2]);
