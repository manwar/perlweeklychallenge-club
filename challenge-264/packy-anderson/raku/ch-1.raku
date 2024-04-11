#!/usr/bin/env raku
use v6;

sub greatestEnglishLetter($str) {
  my %seen;
  my @greatest;

  # find the characters that exist as both
  # upper and lower case in the string
  for $str.split('', :skip-empty) -> $c {

    # note that we've seen the character
    %seen{$c} = 1;

    # swap the case of the character
    my $C = $c.trans(
      ['a' .. 'z', 'A' .. 'Z'] => ['A' .. 'Z', 'a' .. 'z']
    );

    # if we've seen the swapped case version of the char,
    # add the uppercase version to our greatest hits
    @greatest.push: $c.uc if %seen{$C}:exists;
  }

  # if we found greatest characters,
  # return the greater of them
  if (@greatest) {
    return @greatest.max;
  }
  # otherwise, return something that
  # represents an empty result
  return q{''};
}

sub solution($str) {
  say "Input: \$str = '$str'";
  my $output = greatestEnglishLetter($str);
  say "Output: $output";
}

say "Example 1:";
solution('PeRlwEeKLy');

say "\nExample 2:";
solution('ChaLlenge');

say "\nExample 3:";
solution('The');