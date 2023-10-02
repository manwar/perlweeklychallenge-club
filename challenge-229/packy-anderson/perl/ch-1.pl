#!/usr/bin/env perl

use v5.38;

sub quoted_list {
  # given a list, quote the elements and join them with commas
  my @quoted = map { qq{"$_"} } @_;
  return join q{, }, @quoted;
}

sub quoted_english_list {
  # given a list, quote the elements and join them 
  # in a way that makes sense to english speakers
  my @quoted = map { qq{"$_"} } @_;
  my $last = pop @quoted; # last element in array
  if (@quoted == 0) {
    # using an array in a scalar context returns
    # the number of elements in the array

    # there was only one element in the list
    return $last;
  }
  my $joined = join q{, }, @quoted;
  if (@quoted > 1) {
    # if there's more than element, add an Oxford comma
    $joined .= q{,};
  }
  return "$joined and $last";
}

sub is_lexically_sorted {
  my $input = shift @_;

  # get the characters in the input string
  my @characters = split //, $input;

  # generate a string of the characters sorted ascending
  # (with case folding)
  my $forwards  = join q{}, sort {
    fc($a) cmp fc($b)
  } @characters;

  # generate a string of the characters sorted descending
  # (with case folding)
  my $backwards = join q{}, sort {
    fc($b) cmp fc($a)
  } @characters;

  # if the input string is matches either sorted string,
  # then return true
  return( $input eq $forwards || $input eq $backwards );
}

sub solution {
  my @str = @_;
  say "Input: \@str = (" . quoted_list(@str) . ")";

  my @not_lexically_sorted = grep {
    ! is_lexically_sorted($_)
  } @str;

  say "Output: " . scalar(@not_lexically_sorted);
  say "";

  if (@not_lexically_sorted == 0) {
    say "In the given array all elements are"
      . " lexicographically sorted.";
  }
  elsif (@not_lexically_sorted == 1) {
    say "In the given array "
      . quoted_list(@not_lexically_sorted)
      . " is the only element which is not"
      . " lexicographically sorted.";
  }
  else {
    say "In the given array "
      . quoted_english_list(@not_lexically_sorted)
      . " are not lexicographically sorted.";
  }
}

say "Example 1:";
solution("abc", "bce", "cae");

say "";

say "Example 2:";
solution("yxz", "cba", "mon");
