#!/usr/bin/env raku
use v6;

use Lingua::Conjunction;
use Lingua::EN::Numbers;

sub pairCount($string) {
  my $s = $string; # make a copy so we can modify it
  my %count;
  while ($s.chars > 1) {
    my $pair = substr($s, 0..1); # the first two characters
    %count{$pair}++;          # count the pair
    $s = substr($s, 1, *); # remove the first character
  }
  return %count;
}

sub mostFrequentPair($s) {
  # count the letter pairs
  my %pairs = pairCount($s);

  # sort the pairs by their counts
  my @sorted = %pairs.keys.sort: {
    # sort by count first
    %pairs{$^b} <=> %pairs{$^a}
    ||
    # then by lexicographical order
    $^a cmp $^b
  };

  my @max_pair  = shift(@sorted); # pull off first value
  my $max_count = %pairs{@max_pair[0]}; # get it's count

  while ( %pairs{@sorted[0]} == $max_count ) {
    # there are pairs on the sorted list that have the
    # same count, so let's put them on the list, too
    @max_pair.append( shift(@sorted) );
  }
  my $explain;

  # set aside the pair that sorted to the top
  my $first_pair = @max_pair[0];

  # now quote all the pairs
  @max_pair = @max_pair.map: { qq{'$_'} };

  # make the count an english word
  my $count =  ($max_count == 1) ?? 'once'      # 🎶
            !! ($max_count == 2) ?? 'twice'     # 🎶
            !! cardinal($max_count) ~ ' times'; # a lady 🎶

  # and format the explanation
  if (@max_pair == 1) {
    $explain = "'$first_pair' appears $count in \$s";
  }
  else {
    my $str = qq{|list| appear $count in \$s and }
            ~ qq{'$first_pair' is lexicographically smallest.};
    $explain = conjunction @max_pair, :$str;
  }

  return $first_pair, $explain;
}

sub solution($s) {
  say "Input: \$s = '$s'";
  my ($pair, $explain) = mostFrequentPair($s);
  say "Output: '$pair'";
  say "";
  say $explain;
}

say "Example 1:";
solution('abcdbca');

say "\nExample 2:";
solution('cdeabeabfcdfabgcd');

say "\nExample 3:";
solution('abcdeabcde');
