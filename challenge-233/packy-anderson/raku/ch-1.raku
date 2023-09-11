#!/usr/bin/env raku
  
use v6;

sub charsInWord(Str $word) {
  # split the word into characters, then use the Raku
  # array method unique to have each character appear once.
  return $word.split('').unique.sort.join;
}

sub findSimilarWordPairs(*@words where ($_.all ~~ Str)) {
  my %similar;
  for @words -> $word {
    my $charset = charsInWord($word);
    %similar{$charset}.push($word);
  }

  # filter out character sets that only have one word
  my @multiples = %similar.keys.grep: {
    %similar{$_}.elems > 1
  };

  # make pairs by looping over the list
  # of letter sets that had multiple entries
  my @pairs;
  for @multiples -> $charset {
    # if we assign @list = %similar{$charset}, we get
    # an array with a single element, an array object.
    # By using .splice, I can get all the elements in 
    # the array object assigned to @list
    my @list = %similar{$charset}.splice(0, *);

    while ( @list.elems >= 2 ) {
      # remove the first word from the list of words
      my $first = @list.shift;
      # pair it with each of the remaining words
      for @list -> $second {
        @pairs.push([ $first, $second ]);
      }
    }
  }
  return @pairs;
}

sub solution {
  my @words = @_;
  say 'Input: @words = ("' ~ @words.join('", "') ~ '")';

  my @pairs = findSimilarWordPairs(@words);

  say 'Output: ' ~ @pairs.elems;
  my $count = 0;
  for @pairs -> $pair {
    say "" if $count == 0;
    say 'Pair ' ~ ++$count ~ ': similar words ("'
      ~ $pair.join('", "') ~ '")';
  }
}

say "Example 1:";
solution("aba", "aabb", "abcd", "bac", "aabc");

say "";
say "Example 2:";
solution("aabb", "ab", "ba");

say "";
say "Example 3:";
solution("nba", "cba", "dba");