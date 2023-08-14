#!/usr/bin/env raku

use v6;

sub quoted_list ( *@list ) {
  # given a list, quote the elements and join them with commas
  my @quoted = @list.map: { qq{"$_"} };
  return @quoted.join(q{, });
}

sub quoted_english_list ( *@list ) {
  # given a list, quote the elements and join them 
  # in a way that makes sense to english speakers
  my @quoted = @list.map: { qq{"$_"} };
  my $last = @quoted.pop(); # last element in array
  if (@quoted == 0) {
    # using an array in a scalar context returns
    # the number of elements in the array

    # there was only one element in the list
    return $last;
  }
  my $joined = join q{, }, @quoted;
  if (@quoted > 1) {
    # if there's more than element, add an Oxford comma
    $joined ~= q{,};
  }
  return "$joined and $last";
}

sub is_lexically_sorted ($input) {
  # get the characters in the input string
  # putting $input in quotes casts it as a Str
  my @characters = "$input".split("", :skip-empty);

  # sort the characters ascending
  my @forwards  = @characters.sort: { $^a.fc cmp $^b.fc };

  # sort the characters descending
  my @backwards = @characters.sort: { $^b.fc cmp $^a.fc };

  # if the input string is matches either sorted string,
  # then return true
  return( $input eq @forwards.join("")
          ||
          $input eq @backwards.join("") );
}

sub solution (*@str) {
  say "Input: \@str = (" ~ quoted_list(@str) ~ ")";

  my @not_lexically_sorted = @str.grep({
    !is_lexically_sorted($_)
  });

  say "Output: " ~ @not_lexically_sorted.elems;
  say "";

  if (@not_lexically_sorted.elems == 0) {
    say "In the given array all elements are"
      ~ " lexicographically sorted.";
  }
  elsif (@not_lexically_sorted.elems == 1) {
    say "In the given array "
      ~ quoted_list(@not_lexically_sorted)
      ~ " is the only element which is not"
      ~ " lexicographically sorted.";
  }
  else {
    say "In the given array "
      ~ quoted_english_list(@not_lexically_sorted)
      ~ " are not lexicographically sorted.";
  }
}

say "Example 1:";
solution("abc", "bce", "cae");

say "";

say "Example 2:";
solution("yxz", "cba", "mon");