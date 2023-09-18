#!/usr/bin/env perl

use v5.38;

use List::Util qw( min );

sub charFrequency {
  my $word = shift;
  my %freq;
  foreach my $c ( split //, $word ) {
    $freq{$c}++;
  }
  return \%freq; # return a hash REFERENCE
}

sub commonCharacters {
  my @words = @_;
  my @freq = map { charFrequency($_) } @words;
  # grab the character frequency map for the first word
  my $first = shift @freq;
  # now check the characters in the first word against
  # the characters in all the subsequent words
  foreach my $subsequent ( @freq ) {
    foreach my $c ( keys %$first ) {
      if (! exists $subsequent->{$c}) {
        # this character isn't in subsequent words,
        # so let's remove it from the frequency map
        # of the first word
        delete $first->{$c};
      }
      else {
        # the character IS in subsequent words,
        # so let's set the frequency count to be
        # the minimum count found in those words
        $first->{$c} = min($first->{$c}, $subsequent->{$c});
      }
    }
  }

  # now we generate a list of characters in the order they
  # appear in the first word
  my @output;
  # once again, loop over the characters in the first word
  foreach my $c ( split //, $words[0] ) {
    next unless exists $first->{$c};
    if ($first->{$c} > 1) {
      # there's more than one occurence, so let's decrement
      # the count for the next time through the loop
      $first->{$c}--;
    }
    else {
      # there is only one occurence left, so remove the
      # character
      delete $first->{$c};
    }
    push @output, $c;
  }
  return @output;
}

sub solution {
  my @words = @_;
  say 'Input: @words = ("' . join('", "', @words) . '")';
  my @output = commonCharacters(@words);
  say 'Output: ("' . join('", "', @output) . '")';
}

say "Example 1:";
solution("java", "javascript", "julia");

say "\nExample 2:";
solution("bella", "label", "roller");

say "\nExample 3:";
solution("cool", "lock", "cook");
