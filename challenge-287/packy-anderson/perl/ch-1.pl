#!/usr/bin/env perl
use v5.40;
use utf8;
binmode STDOUT, ':utf8';

sub strongPassword($str) {
  my ($hasUpper, $hasLower, $hasDigit, @runs) = (0, 0, 0);

  foreach my $char ( split //, $str ) {
    # identify runs of characters
    if (@runs == 0 || substr($runs[-1],-1,1) ne $char) {
      # we have no previous run of characters, or the last
      # character of the last run doesn't match this character
      push @runs, $char;
    }
    else {
      # append the latest character to the run
      $runs[-1] .= $char;
    }

    # count the character classes we're interested in
    if    ($char =~ /\p{Lu}/) { $hasUpper++ }
    elsif ($char =~ /\p{Ll}/) { $hasLower++ }
    elsif ($char =~ /\p{N}/)  { $hasDigit++ }
  }

  # count how many characters need to be REPLACED
  my $replacements = 0;
  foreach my $run ( @runs ) {
    # the run isn't 3 or more characters
    next unless length($run) >= 3;
    # we need one replacement per multiple of 3
    $replacements += int(length($run) / 3);
  }

  # figure out how many changes are needed
  my $changes = 0;
  my $length  = length($str);

  foreach my $has ($hasUpper, $hasLower, $hasDigit) {
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
  say 'Output: ' . strongPassword($str);
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
