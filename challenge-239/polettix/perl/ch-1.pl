#!/usr/bin/env perl
use v5.24;
use warnings;

my ($s1, $s2) = map { [ split m{,}mxs ]  } @ARGV[0,1];
say is_same_string($s1, $s2) ? 'true' : 'false';

sub is_same_string {
   my ($lead, @other) = map {
      my $aref = $_;
      my $idx = 0;
      my $ch_idx = 0;
      sub {
         while ($idx <= $aref->$#*) {
            return substr($aref->[$idx], $ch_idx++, 1)
               if $ch_idx < length($aref->[$idx]);
            ++$idx;
            $ch_idx = 0;
         }
         return;
      };
   } @_;
   while ('necessary') {
      my $ch = $lead->();
      if (! defined($ch)) {
         for my $it (@other) {
            return 0 if defined($it->());
         }
         return 1;
      }
      for my $it (@other) {
         my $och = $it->();
         return 0 if ($och // '') ne $ch;
      }
   }
}
