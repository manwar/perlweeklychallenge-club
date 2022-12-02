#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @strings = @ARGV ? @ARGV : qw< adc wzy abc >;
say odd_string(@strings);

sub odd_string (@strings) {
   my @pre = map { ord substr $_, 0, 1 } @strings;
   for my $i (1 .. $#strings) {
      my %string_for;
      my $n_different = 0;
      my @cur;
      my $j = 0;
      for my $string (@strings) {
         my $delta = ord(substr $string, $i, 1) - $pre[$j++];
         if (! $n_different) {
            $string_for{$delta} = $string;
            ++$n_different;
         }
         elsif ($n_different == 1) {
            if (exists $string_for{$delta}) {
               $string_for{$delta} = [];
            }
            elsif (ref((values %string_for)[0])) {
               return $string;
            }
            else {
               $string_for{$delta} = $string;
               ++$n_different;
            }
         }
         elsif ($n_different == 2) {
            delete $string_for{$delta};
            return((values %string_for)[0]);
         }
      }
   }
}
