#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say good_strings(@ARGV);

sub good_strings ($chars, @words) {
   my %available;
   $available{$_}++ for split m{}mxs, $chars;
   my $retval = 0;
   WORD:
   for my $word (@words) {
      my %residual;
      for my $c (split m{}mxs, $word) {
         $residual{$c} //= $available{$c} // 0;
         next WORD if --$residual{$c} < 0;
      }
      $retval += length($word);
   }
   return $retval;
}
