#!/usr/bin/env perl
# Perl weekly challenge 099
# Task 1: Pattern match
#
# See https://wlmb.github.io/2021/02/08/PWC099/#task-1-pattern-match
  use warnings;
  use strict;
  use v5.12;

  my ($S, $P0)=@ARGV;
  my $P=quotemeta $P0; # quote anything suspicious
  $P=~s/^\\\*/.*/; # Replace originally unquoted asterisks
  $P=~s/([^\\])\\\*/$1.*/g;
  $P=~s/\\\\\*/\*/g; #Replace originally quoted asterisks
  $P=~s/^\\\?/./; # Replace originally unquoted question marks
  $P=~s/([^\\])\\\?/$1./g;
  $P=~s/\\\\\?/\?/g; #Replace originally quoted question marks
  say "Input: \$S=\"$S\" \$P=\"$P0\"\nOutput: ", $S=~/^$P$/?1:0;
