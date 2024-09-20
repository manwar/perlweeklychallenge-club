#!/usr/bin/env raku
use v6;

sub strongPassword($str) {
  my ($hasUpper, $hasLower, $hasDigit, @runs) = (0, 0, 0);

  for $str.comb -> $char {
    # identify runs of characters
    if (@runs == 0 || @runs[*-1].substr(*-1,1) ne $char) {
      # we have no previous run of characters, or the last
      # character of the last run doesn't match this character
      @runs.push($char);
    }
    else {
      # append the latest character to the run
      @runs[*-1] ~= $char;
    }

    # count the character classes we're interested in
    if    ($char ~~ / <:Lu> /) { $hasUpper++ }
    elsif ($char ~~ / <:Ll> /) { $hasLower++ }
    elsif ($char ~~ / <:N> /)  { $hasDigit++ }
  }

  # count how many characters need to be REPLACED
  my $replacements = 0;
  for @runs -> $run {
    # the run isn't 3 or more characters
    next unless $run.chars >= 3;
    # we need one replacement per multiple of 3
    $replacements += ($run.chars / 3).Int;
  }

  # figure out how many changes are needed
  my $changes = 0;
  my $length  = $str.chars;

  for [$hasUpper, $hasLower, $hasDigit] -> $has {
    if ($has == 0) {
      $changes++; # we need to add a character of this type

      # if we have characters that need to be REPLACED, we don't
      # need to add to the string length to make the change
      if ($replacements > 0) {
        $replacements--;
      }
      else {
        # we need to add characters to make the change
        $length++;
      }
    }
  }
  if ($length < 6) {
    # not enough characters, we need MORE!
    $changes += 6 - $length;
  }
  if ($replacements > 0) {
    # if we need more replacements, add them to the total
    $changes += $replacements;
  }

  return $changes;
}

sub solution($str) {
  say qq{Input: \$str = "$str"};
  say 'Output: ' ~ strongPassword($str);
}

say "Example 1:";
solution("a");

say "\nExample 2:";
solution("aB2");

say "\nExample 3:";
solution("PaaSW0rd");

say "\nExample 4:";
solution("Paaasw0rd");

say "\nExample 5:";
solution("aaaaa");

say "\nExample 6:";
solution("aaaaaabbbb");

say "\nExample 7:";
solution("voilÀ३");
