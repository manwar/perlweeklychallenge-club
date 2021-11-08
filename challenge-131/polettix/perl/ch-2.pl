#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub find_pairs ($delimiter_pairs, $search_string) {
   my @delimiters = ('', '');
   while ($delimiter_pairs) {
      $delimiters[$_] .= substr $delimiter_pairs, 0, 1, '' for 0, 1;
   }
   return map { $search_string =~ s{[^\Q$_\E]+}{}rgmxs } @delimiters;
} ## end sub find_pairs

say
  for find_pairs(@ARGV
   ? @ARGV
   : ('""[]()', '"I like (parens) and the Apple ][+" they said.'));
