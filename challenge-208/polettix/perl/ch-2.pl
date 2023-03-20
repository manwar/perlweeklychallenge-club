#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

our $SHORT_CIRCUIT = $ENV{SHORT_CIRCUIT} // 1;
if (my @dam = duplicate_and_missing(@ARGV)) {
   local $" = ',';
   say "(@dam)";
}
else {
   say -1;
}

sub duplicate_and_missing (@list) {
   my ($duplicate, $missing, @retval);
   for my $i (1 .. $#list) {
      if ($list[$i] == $list[$i - 1]) {
         die "too many duplicates ($duplicate, $list[$i])\n"
            if defined $duplicate;
         push @retval, $duplicate = $list[$i];
      }
      elsif ($list[$i] == $list[$i - 1] + 2) {
         my $miss = $list[$i] - 1;
         die "too many missing ($missing, $miss)\n" if defined $missing;
         push @retval, $missing = $miss;
      }
      elsif ($list[$i] != $list[$i - 1] + 1) {
         die "unexpected gap\n";
      }
      else {} # just a simple increment
      return @retval if @retval == 2 && our $SHORT_CIRCUIT;
   }
   return unless defined($duplicate);
   push @retval, $list[-1] + 1 unless @retval == 2;
   return @retval;
}
