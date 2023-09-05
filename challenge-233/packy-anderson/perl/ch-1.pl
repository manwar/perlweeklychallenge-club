#!/usr/bin/env perl
  
use v5.38;

sub charsInWord {
  my $word = shift;
  # split the word into characters, then map those
  # characters to a hash so we only have unique ones
  my %charset = map { $_ => 1 } split //, $word;
  # return the set of characters as a string, sorted
  return join q{}, sort keys %charset;
}

sub findSimilarWordPairs {
  my @words = @_;

  # get the set of characters in each word,
  # store each word in an array reference under
  # the hash key for its character set
  my %similar;
  foreach my $word ( @words ) {
    my $charset = charsInWord($word);
    # if $similar{$charset} is undefined when we
    # try to use it as an array reference to store
    # a value, Perl will "autovivify" a reference
    # to an empty array
    push @{ $similar{$charset} }, $word;
  }

  # filter out character sets that only have one word
  my @multiples = grep {
    scalar( @{ $similar{$_} } ) > 1
  } keys %similar;

  # make pairs by looping over the list
  # of letter sets that had multiple entries
  my @pairs;
  foreach my $charset ( @multiples ) {
    my @list = @{ $similar{$charset} };

    while ( scalar(@list) >= 2 ) {
      # remove the first word from the list of words
      my $first = shift @list;
      # pair it with each of the remaining words
      foreach my $second ( @list ) {
        push @pairs, [ $first, $second ];
      }
    }
  }
  return @pairs;
}

sub solution {
  my @words = @_;
  say 'Input: @words = ("' . join('", "', @words) . '")';

  my @pairs = findSimilarWordPairs(@words);

  say 'Output: ' . scalar(@pairs);
  my $count = 0;
  foreach my $pair ( @pairs ) {
    say "" if $count == 0;
    say 'Pair ' . ++$count . ': similar words ("'
      . join('", "', @$pair) . '")';
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