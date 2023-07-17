#!/usr/bin/env perl
use v5.36;

sub shuffle_string {
  my($string, $indices) = @_;
  my @chars = split //, $string; # split input string into characters
  my @result;
  foreach my $index ( @$indices ) {
    my $char  = shift @chars;     # get the next character
    $result[$index] = $char;      # put the character at that index in the result
  }
  say "Input: \$string = '$string', \@indices = (" . join(',', @$indices) . ")";
  say "Output: '" . join(q{}, @result) . "'";
}

say "Task 1: Shuffle String";
say "\nExample 1";
shuffle_string('lacelengh', [3,2,0,5,4,8,6,7,1]);
say "\nExample 2";
shuffle_string('rulepark', [4,7,3,1,0,5,2,6]);
