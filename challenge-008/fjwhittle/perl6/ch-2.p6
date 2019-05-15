#!/usr/bin/env perl6

sub centre(*@lines) {
  # Get the maximum trimmed length of all provided lines.
  my $max = @lines».Str».trim».chars.max;

  # Map lines to a string format at the average length to the maximum.
  @lines.map: {
    sprintf('%*s', (.trim.chars + $max) div 2, .trim);
  }
}

.put for centre(@*ARGS || ('This', 'is', 'a test of the', 'centre function'));
