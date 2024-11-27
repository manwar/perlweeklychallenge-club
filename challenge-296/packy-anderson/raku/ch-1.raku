#!/usr/bin/env raku
use v6;

sub rlEncode($str) {
  my @chars = $str.comb;
  my $last = @chars.shift;
  my $count = 1;
  my $result;
  for @chars -> $c {
    if ($c eq $last) { # same as last char,
      $count++;        # increment the count
    }
    else {
      if ($count > 1) {    # if the count > 1, include the
        $result ~= $count; # count in the encoded output
      }
      $result ~= $last; # add the last character to the output
      $last = $c; # make current char the last
      $count = 1; # and reset the count
    }
  }
  # encode the last run of characters in the string
  if ($count > 1) {
    $result ~= $count;
  }
  $result ~= $last;

  return $result;
}

sub rlDecode($str) {
  my @chars = $str.comb(/<digit>+|<alpha>/);
  my $result;
  while (my $c = @chars.shift) {
    if ($c ~~ /<alpha>/) { # it's an alphabetic character
      $result ~= $c;
    }
    else { # it's a numeric count
      my $count = $c;
      $c = @chars.shift; # get the next character
      $result ~= $c x $count;
    }
  }
  return $result;
}

sub solution($str) {
  say qq{Input: \$chars = "$str"};
  my $encoded = rlEncode($str);
  say qq{Encoded: "$encoded"};
  my $decoded = rlDecode($encoded);
  say qq{Decoded: "$decoded"};
}

say "Example 1:";
solution("abbc");

say "\nExample 2:";
solution("aaabccc");

say "\nExample 3:";
solution("abcc");

say "\nExample 4:";
solution("abbbbbbbbbbbbccccccdd");
