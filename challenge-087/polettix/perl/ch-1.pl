#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

my @N = @ARGV ? @ARGV : (100, 4, 50, 3, 2);
local $" = ', ';
my @lcs;

longest_consecutive_sequence(\&lcs_basic, @N);
longest_consecutive_sequence(\&lcs_less_basic, @N);
longest_consecutive_sequence(\&lcs_with_iterators, @N);

sub longest_consecutive_sequence ($sub, @N) {
   my @sequence = $sub->(@N);
   local $" = ', ';
   say((@sequence > 1) ? "(@sequence)" : '0');
}

sub lcs_basic (@N) {
   return unless @N;
   @N = sort {$a <=> $b} @N;
   my ($ls, $ll, $cs, $cl) = (0, 0, 0, 1);
   for my $i (1 .. $#N, -1) {
      if ($i >= 0 && $N[$i] == $N[$i - 1] + 1) { # consecutive
         $cl++;
      }
      else { # end or not consecutive
         ($ls, $ll) = ($cs, $cl) if $cl > $ll;
         ($cs, $cl) = ($i, 1);
      }
   }
   return @N[$ls .. ($ls + $ll - 1)];
}

sub lcs_less_basic (@N) {
   return unless @N;
   @N = sort {$a <=> $b} @N;
   my ($ls, $ll, $cs, $cl) = (0, 0, 0, 1);
   for my $i (1 .. $#N, -1) {
      if ($i >= 0 && $N[$i] == $N[$i - 1] + 1) { # consecutive
         $cl++;
      }
      else { # end or not consecutive
         ($ls, $ll) = ($cs, $cl) if $cl > $ll;
         last if $ll >= $#N - $i + 1; # compare with max residual length
         ($cs, $cl) = ($i, 1);
      }
   }
   return @N[$ls .. ($ls + $ll - 1)];
}

sub lcs_with_iterators (@N) {
   my $iterator = lcs_iterator(@N);
   my $longest = [];
   while (my $sequence = $iterator->()) {
      $longest = $sequence if $sequence->@* > $longest->@*;
   }
   return $longest->@*;
}

sub lcs_iterator (@N) {
   @N = sort {$a <=> $b} @N;
   return sub {
      return unless @N;
      my @sequence = shift @N;
      push @sequence, shift @N while @N && $N[0] == $sequence[-1] + 1;
      return \@sequence;
   };
}
