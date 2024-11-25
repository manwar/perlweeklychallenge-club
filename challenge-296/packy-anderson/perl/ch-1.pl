#!/usr/bin/env perl
use v5.40;

sub rlEncode($str) {
  my @chars = split //, $str;
  my $last = shift @chars;
  my $count = 1;
  my $result;
  foreach my $c ( @chars ) {
    if ($c eq $last) { # same as last char,
      $count++;        # increment the count
    }
    else {
      if ($count > 1) {    # if the count > 1, include the
        $result .= $count; # count in the encoded output
      }
      $result .= $last; # add the last character to the output
      $last = $c; # make current char the last
      $count = 1; # and reset the count
    }
  }
  # encode the last run of characters in the string
  if ($count > 1) {
    $result .= $count;
  }
  $result .= $last;

  return $result;
}

sub rlDecode($str) {
  my $result = '';
  my $count = '';
  foreach my $c (split //, $str) {
    if ($c =~ /\D/) { # it's an alphabetic character
      if ($count) { # if there's a count
        $result .= $c x $count; # output that many of this char
        $count = ''; # reset the count
      }
      else { # append character to output
        $result .= $c;
      }
    }
    else { # it's part of a numeric count
      $count .= $c;
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
