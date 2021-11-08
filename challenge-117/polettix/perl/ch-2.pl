#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

use constant THRESHOLD => 10;

sub find_possible_paths ($N) {
   my @solution = (['']);
   for my $i (1 .. $N) {
      my @new_iteration = [];
      for my $j (0 .. $#solution) {
         my $previous = $solution[$j];
         my $left     = $new_iteration[$j];
         my $right    = $new_iteration[$j + 1] = [];
         for my $p ($previous->@*) {
            push $left->@*, $p . 'L';
            push $right->@*, $p . 'R';
         }
         for my $p ($left->@*) {
            push $right->@*, $p . 'H';
         }
      }
      @solution = @new_iteration;
   }
   return $solution[-1]->@*;
}

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
      }
      for my $incc (reverse(-1, 0 .. ($k - 1))) {
         if ($incc < 0) {
            @indexes = (); # finished!
         }
         elsif ((my $v = $indexes[$incc]) < $incc - $k + $n) {
            $indexes[$_] = ++$v for $incc .. ($k - 1);
            last;
         }
      }
      return \@combination;
   }
}

sub basic_case_iterator_longer ($N) {
   my $N2 = 2 * $N;
   my $cs;
   return sub {
      $cs //= combinations_iterator($N, 0 .. $N2 - 1);
      CANDIDATE:
      while (my $Ls = $cs->()) {
         my @sequence = ('H') x $N2;
         @sequence[$Ls->@*] = ('L') x $N;
         my $count = 0;
         for my $item (@sequence) {
            $count += $item eq 'L' ? 1 : -1;
            next CANDIDATE if $count < 0;
         }
         return join '', @sequence;
      }
      return;
   };
}

sub basic_case_iterator ($N) {
   --$N;
   my $N2 = 2 * $N;
   my $cs;
   return sub {
      $cs //= combinations_iterator($N, 0 .. $N2 - 1);
      CANDIDATE:
      while (my $Ls = $cs->()) {
         my @sequence = ('H') x $N2;
         @sequence[$Ls->@*] = ('L') x $N;
         my $count = 1;  # we will force starting with an L
         for my $item (@sequence) {
            $count += $item eq 'L' ? 1 : -1;
            next CANDIDATE if $count < 0;
         }
         return join '', 'L', @sequence, 'H';
      }
      return;
   };
}

sub expand_with_Rs_iterator ($sequence) {
   my $indexes;
   my @parts;
   my ($i, $n, $max);
   return sub {
      if (! $indexes) { # initialize
         @parts = grep {length} split m{(LH)}mxs, $sequence;
         $indexes = [grep {$parts[$_] eq 'LH'} 0 .. $#parts];
         $n = $indexes->@*;
         $max = 0;
         $max = ($max << 1) | 1 for 1 .. $n;
         $i = 0;
         return $sequence;
      }
      return if $i >= $max;
      ++$i;
      my @Rs = split m{}mxs, sprintf "%0${n}b", $i;
      my @copy = @parts;
      for my $j (0 .. $#Rs) {
         next unless $Rs[$j];
         $copy[$indexes->[$j]] = 'R';
      }
      return join '', @copy;
   };
}

sub find_possible_paths_iterator ($N) {
   my ($basic_it, $fit);
   return sub {
      $basic_it //= basic_case_iterator($N);
      while ('necessary') {
         $fit //= expand_with_Rs_iterator($basic_it->() // return);
         if (my $item = $fit->()) { return $item }
         $fit = undef;
      }
   };
}

my $n = shift // 2;
my $use_iterator = $ENV{USE_ITERATOR} ? 1
   : defined($ENV{USE_ITERATOR})      ? 0
   : $n > THRESHOLD;
if ($use_iterator) {
   my $it = find_possible_paths_iterator($n);
   while (my $c = $it->()) { say $c }
}
else {
   say for find_possible_paths($n);
}
