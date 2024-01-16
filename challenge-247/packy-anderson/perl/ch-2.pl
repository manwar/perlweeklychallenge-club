#!/usr/bin/env perl
use v5.38;

use Lingua::EN::Inflexion qw( noun wordlist );

sub pairCount($s) {
  my %count;
  while (length($s) > 1) {
    my $pair = substr($s, 0, 2); # the first two characters
    $count{$pair}++;        # count the pair
    $s = substr($s, 1); # remove the first character
  }
  return %count;
}

sub mostFrequentPair($s) {
  # count the letter pairs
  my %pairs = pairCount($s);

  # sort the pairs by their counts
  my @sorted = sort {
    # sort by count first
    $pairs{$b} <=> $pairs{$a}
    ||
    # then by lexicographical order
    $a cmp $b
  } keys %pairs;

  my @max_pair  = shift(@sorted); # pull off first value
  my $max_count = $pairs{$max_pair[0]}; # get it's count

  while ( $pairs{$sorted[0]} == $max_count ) {
    # there are pairs on the sorted list that have the
    # same count, so let's put them on the list, too
    push @max_pair, shift(@sorted);
  }
  my $explain;

  # set aside the pair that sorted to the top
  my $first_pair = $max_pair[0];

  # now quote all the pairs
  my $pair_list = wordlist( map { qq{'$_'} } @max_pair );

  # make the count an english word
  my $count = ($max_count == 1) ? 'once'             # 🎶
            : ($max_count == 2) ? 'twice'            # 🎶
            : noun($max_count)->cardinal . ' times'; # a lady 🎶

  # and format the explanation
  if (@max_pair == 1) {
    $explain = "'$first_pair' appears $count in \$s";
  }
  else {
    $explain = $pair_list . " appear $count in \$s and "
             . "'$first_pair' is lexicographically smallest.";
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