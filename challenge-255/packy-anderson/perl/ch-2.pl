#!/usr/bin/env perl
use v5.38;

sub frequentWord($p, $w) {
  # first, remove punctuation from the paragraph
  # (but we'll leave apostrophes for contractions)
  $p =~ s/[^a-z'\s]//ig;

  # count the words in $paragraph
  my %count;
  foreach my $pw ( split(/\s+/, lc($p)) ) {
    $count{$pw}++;
  }

  # generate the output about the banned word
  my $bannedCount = $count{$w} // 0;
  my $output = qq/The banned word "$w" occurs $bannedCount /;
  $output .= ($bannedCount == 1) ? 'time' : 'times';
  $output .= ".\n";

  # delete the banned word from the word count
  delete $count{$w};

  # now find the most frequent word left and report on that
  my @sorted = sort {
    # sort by count
    $count{$b} <=> $count{$a}
  } keys %count;
  my $freqWord  = $sorted[0];
  my $freqCount = $count{$freqWord};

  $output .= qq/The other word "$freqWord" /;
  $output .= qq/occurs $freqCount /;
  $output .= ($freqCount == 1) ? 'time.' : 'times.';

  return $freqWord, $output;
}

sub solution($p, $w) {
  say qq/Input: \$p = "$p"/;
  say qq/       \$w = "$w"/;
  my ($freqWord, $output) = frequentWord($p, $w);
  say qq/Output: "$freqWord"/;
  say "";
  say $output;
}

say "Example 1:";
solution(
  "Joe hit a ball, the hit ball flew far after it was hit.",
  "hit"
);

say "\nExample 2:";
solution(
  "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
  "the"
);
