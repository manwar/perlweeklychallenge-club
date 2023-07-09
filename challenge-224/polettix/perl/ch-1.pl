#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say special_notes(@ARGV) ? 'true' : 'false';

sub special_notes_simple ($source, $target) {
   my %available;
   $available{$_}++ for split m{}mxs, $source;
   for my $char (split m{}mxs, $target) {
      return unless $available{$char};
      $available{$char}--;
   }
   return 1;
}

sub special_notes ($source, $target) {
   my $sl = length($source);
   my $tl = length($target);
   return unless $tl <= $sl;

   my %available;
   my $si = 0; # index in $source
   TARGET:
   for my $ti (0 .. $tl - 1) {
      my $tch = substr($target, $ti, 1);
      if ($available{$tch}) {
         my $residual = --$available{$tch};
         delete $available{$tch} unless $residual;
      }
      else {
         while ($si < $sl) {
            my $sch = substr($source, $si++, 1);
            next TARGET if $sch eq $tch;
            ++$available{$sch};
         }
         return; # no luck...
      }
   }
   return 1;
}
