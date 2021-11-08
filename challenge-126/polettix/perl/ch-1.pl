#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Benchmark 'cmpthese';

my $N = shift || 15;
say 'brute force: ', count_like_no_ones_bf($N) if $N < 1000;
say 'iterative:   ', count_like_no_ones($N);
say 'recursive:   ', count_like_no_ones_r($N);

exit 0 unless $ENV{BENCHMARK};

#my @inputs = 0 .. 9999;
my @inputs = 99999999990000 .. 99999999999999;
cmpthese(-5,
   {
      #brute     => sub { count_like_no_ones_bf($_) for @inputs },
      recursive => sub { count_like_no_ones_r($_) for @inputs },
      iterative => sub { count_like_no_ones($_) for @inputs },
   }
);

say 'done';

sub count_like_no_ones_bf ($N) { scalar grep {! m{1}mxs} 2 .. $N }

sub count_like_no_ones ($N) {
   my $count = 0;
   my @digits = split m{}mxs, $N;
   while (@digits) {
      my $first = shift @digits;
      if (@digits) { # more to go after, use chunking
         my $factor = $first > 1 ? $first - 1 : $first;
         $count += $factor * 9 ** @digits;
      }
      else { # last digit, count all including 0
         $count += $first > 1 ? $first : 1;
      }
      last if ($first == 1);
   }
   # we took into account sequence of all 0, so we remove it
   return $count - 1;
}

sub count_like_no_ones_r ($N) {
   return($N > 1 ? $N - 1 : 0) if $N < 10;
   my $first = substr $N, 0, 1, '';
   my $factor = $first > 1 ? $first - 1 : $first;
   my $count = $factor * 9 ** length($N);
   $count += 1 + count_like_no_ones_r($N) if $first != 1;
   return $count - 1;
}
