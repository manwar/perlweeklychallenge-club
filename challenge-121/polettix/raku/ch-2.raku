#!/usr/bin/env raku
use v6;

sub travelling-salesman-problem ($dist-from-to) {
   my $n = $dist-from-to.elems;
   my \U = 1 ..^ $n;
   my %g = map { $_ => $dist-from-to[0][$_] }, U;
   my %p = map { $_ => 0 }, U;
   for 2 ..^ $n -> $size {
      for combinations(U, $size) -> $S {
         for |$S -> $e {
            my $Se = $S (-) $e;
            my $eSe-key = ($e, $Se.keys.sort.Slip).join(',');
            for $Se.keys -> $m {
               my $Sem = $Se (-) $m;
               my $mSem-key = ($m, $Sem.keys.sort.Slip).join(',');
               my $candidate = %g{$mSem-key} + $dist-from-to[$m][$e];
               (%g{$eSe-key}, %p{$eSe-key}) = ($candidate, $m)
                  if %g{$eSe-key}:!exists || $candidate < %g{$eSe-key};
            }
         }
      }
   }
   my ($opt, $opt-dist);
   for U -> $e {
      my $Se = U (-) $e;
      my $eSe-key = ($e, $Se.keys.sort.Slip).join(',');
      my $candidate = %g{$eSe-key} + $dist-from-to[$e][0];
      ($opt, $opt-dist) = ($e, $candidate)
         if ! defined($opt-dist) || $candidate < $opt-dist;
   }
   my @path = 0;
   my $S = U;
   my $e = $opt;
   while $e {
      @path.unshift: $e;
      $S = $S (-) $e;
      my $key = ($e, $S.keys.sort.Slip).join(',');
      $e = %p{$key};
   }
   @path.unshift: 0;
   ($opt-dist, @path.List);
}

sub tsp-bf ($dist-from-to) {
   my $n = $dist-from-to.elems;
   my ($best-distance, $best-path);
   for permutations(1 .. $n - 1) -> $perm {
      my $from = 0;
      my $sum = 0;
      for |$perm, 0 -> $to {
         $sum += $dist-from-to[$from][$to];
         $from = $to;
      }
      ($best-distance, $best-path) = ($sum, $perm)
         if ! defined($best-distance) || $sum < $best-distance;
   }
   return ($best-distance, (0, |$best-path, 0));
}

sub generate-randoms ($n) {
   my @retval;
   for 0 ..^ $n -> $i {
      my @row = (1 .. $n).map({1 + 13.rand.Int});
      @row[$i] = 0;
      @retval.push: @row.List;
   }
   return @retval;
}

# my $dft = (
#    [0, 5, 2, 7, 9],
#    [5, 0, 5, 3, 1],
#    [3, 1, 0, 6, 2],
#    [4, 5, 4, 0, 12],
#    [1, 5, 7, 2, 0],
# );

my $n = @*ARGS ?? @*ARGS.shift !! 4;
my $dft = generate-randoms($n);

tsp-bf($dft).say if $n < 8;
travelling-salesman-problem($dft).say;
