#!/usr/bin/env raku
use v6;

sub frequentWord($p, $w) {
  # assign the value to a container so we can modify it
  my $paragraph = $p;

  # first, remove punctuation from the paragraph
  # (but we'll leave apostrophes for contractions)
  $paragraph ~~ s:i:g/<-[a..z'\s]>//;

  # count the words in $paragraph
  my %count;
  for $paragraph.lc.split(' ', :skip-empty) -> $pw {
    %count{$pw}++;
  }

  # generate the output about the banned word
  my $bannedCount = %count{$w} // 0;
  my $output = qq/The banned word "$w" occurs $bannedCount /;
  $output ~= ($bannedCount == 1) ?? 'time' !! 'times';
  $output ~= ".\n";

  # delete the banned word from the word count
  %count{$w}:delete;

  # now find the most frequent word left and report on that
  my @sorted = %count.keys.sort: {
    # sort by count
    %count{$^b} <=> %count{$^a}
  };
  my $freqWord  = @sorted[0];
  my $freqCount = %count{$freqWord};

  $output ~= qq/The other word "$freqWord" /;
  $output ~= qq/occurs $freqCount /;
  $output ~= ($freqCount == 1) ?? 'time.' !! 'times.';

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
