#!/usr/bin/env raku
use v6;

sub int-sums-iterator (Int:D $N, Int :$max) {
   if ($N < 1) {
      my @retvals = $[];
      return sub { @retvals.shift };
   }
   $max //= $N;
   my $first = $N < $max ?? $N !! $max;
   my $rit;
   return sub {
      my @retval;
      while ($first > 0) {
         $rit //= int-sums-iterator($N - $first, max => $first);
         if (defined(my $rest = $rit())) {
            return [$first, |$rest];
         }
         ($first, $rit) = ($first - 1);
      }
      return;
   }
}

sub basketball-points ($S) {
   my $isi = int-sums-iterator($S, max => 3);
   my (@ps, %seen);
   return sub {
      loop {
         if ! @ps {
            defined(my $cmb = $isi()) or return;
            @ps = permutations($cmb);
            %seen = ();
         }
         if @ps {
            my @candidate = @ps.shift;
            my $key = @candidate.join: ' ';
            return |@candidate unless %seen{$key}++;
         }
      }
   }
}

my $n = @*ARGS ?? @*ARGS[0] !! 5;
my $bp = basketball-points($n);
while $bp() -> $cmb {
   $cmb.join(' ').put;
}
