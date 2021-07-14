#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub travelling_salesman_problem ($dist_from_to) {
   my $n = $dist_from_to->@*;
   my @U = 1 .. $n - 1;
   my %g = map { $_ => $dist_from_to->[0][$_] } @U;
   my %p = map { $_ => 0 } @U;
   for my $size (2 .. $n - 1) {
      my $cit = combinations_iterator($size, @U);
      while (my @S = $cit->()) {
         for my $e (@S) {
            my @Se = grep { $_ != $e } @S;
            my $eSe_key = join ',', $e, @Se;
            for my $m (@Se) {
               my @Sem = grep { $_ != $m } @Se;
               my $mSem_key = join ',', $m, @Sem;
               my $candidate = $g{$mSem_key} + $dist_from_to->[$m][$e];
               ($g{$eSe_key}, $p{$eSe_key}) = ($candidate, $m)
                  if ! exists $g{$eSe_key} || $candidate < $g{$eSe_key};
            }
         }
      }
   }
   my ($opt, $opt_dist);
   for my $e (@U) {
      my @Se = grep { $_ != $e } @U;
      my $eSe_key = join ',', $e, @Se;
      my $candidate = $g{$eSe_key} + $dist_from_to->[$e][0];
      ($opt, $opt_dist) = ($e, $candidate)
         if ! defined($opt_dist) || $candidate < $opt_dist;
   }

   my @path = (0);
   my @S = @U;
   my $e = $opt;
   while ($e) {
      unshift @path, $e;
      @S = grep { $_ != $e } @S;
      my $key = join ',', $e, @S;
      $e = $p{$key};
   }
   unshift @path, 0;
   return ($opt_dist, \@path);
}

sub tsp_bf ($dist_from_to) {
   my $n = $dist_from_to->@*;
   my ($best_distance, $best_path);
   my $pit = permutations_iterator(items => [1 .. $n - 1]);
   while (my @perm = $pit->()) {
      my ($from, $sum) = (0, 0);
      for my $to (@perm, 0) {
         $sum += $dist_from_to->[$from][$to];
         $from = $to;
      }
      ($best_distance, $best_path) = ($sum, [@perm])
        if !defined($best_distance) || $sum < $best_distance;
   } ## end while (my @perm = $pit->(...))
   return ($best_distance, [0, $best_path->@*, 0]);
} ## end sub tsp_bf ($dist_from_to)

sub permutations_iterator {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my $items = $args{items} || die "invalid or missing parameter 'items'";
   my $filter  = $args{filter} || sub { wantarray ? @_ : [@_] };
   my @indexes = 0 .. $#$items;
   my @stack   = (0) x @indexes;
   my $sp      = undef;
   return sub {
      if (!defined $sp) { $sp = 0 }
      else {
         while ($sp < @indexes) {
            if ($stack[$sp] < $sp) {
               my $other = $sp % 2 ? $stack[$sp] : 0;
               @indexes[$sp, $other] = @indexes[$other, $sp];
               $stack[$sp]++;
               $sp = 0;
               last;
            } ## end if ($stack[$sp] < $sp)
            else {
               $stack[$sp++] = 0;
            }
         } ## end while ($sp < @indexes)
      } ## end else [ if (!defined $sp) ]
      return $filter->(@{$items}[@indexes]) if $sp < @indexes;
      return;
     }
} ## end sub permutations_iterator

sub combinations_iterator ($k, @items) {
   my @indexes = (0 .. ($k - 1));
   my $n = @items;
   return sub {
      return unless @indexes;
      my (@combination, @remaining);
      my $j = 0;
      for my $i (0 .. ($n - 1)) {
         if ($j < $k && $i == $indexes[$j]) {
            push @combination, $items[$i];
            ++$j;
         }
         else {
            push @remaining, $items[$i];
         }
      } ## end for my $i (0 .. ($n - 1...))
      for my $incc (reverse(-1, 0 .. ($k - 1))) {
         if ($incc < 0) {
            @indexes = ();    # finished!
         }
         elsif ((my $v = $indexes[$incc]) < $incc - $k + $n) {
            $indexes[$_] = ++$v for $incc .. ($k - 1);
            last;
         }
      } ## end for my $incc (reverse(-1...))
      return @combination;
     }
} ## end sub combinations_iterator

sub generate_randoms ($n) {
   my @retval;
   for my $i (0 .. $n - 1) {
      my @row = map { 1 + int(rand 13) } 1 .. $n;
      $row[$i] = 0;
      push @retval, \@row;
   }
   return \@retval;
}

my $n = shift || 4;
my $dft = generate_randoms($n);

if ($n < 10) { # limit brute-force
   my ($dist, $path) = tsp_bf($dft);
   say "$dist ($path->@*)";
}

{ # Held-Karp algorithm
   my ($dist, $path) = travelling_salesman_problem($dft);
   say "$dist ($path->@*)";
}
