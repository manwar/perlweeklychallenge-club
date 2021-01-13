#!/usr/bin/env perl
use strict;
use warnings;
use English qw< -no_match_vars >;
use autodie;

main(shift || 1);

sub main {
   my ($n) = @_;

   # compute the "basic" Zeckendorf decomposition of $n
   my $lk = lekkerkerker($n);

   # compute a "reasonable" decomposition into possible non-overlapping
   # components
   my @components;
   for my $i (reverse 0 .. $#{$lk->{indexes}}) {
      my $index = $lk->{indexes}[$i];
      my $low_index = $i ? $lk->{indexes}[$i - 1] : 0;
      my $alts = alternatives($index, $low_index);
      push @components, $alts;
   }

   # compute all possible arrangements, reject those with overlaps and
   # print the others
   nested_loops_recursive(
      \@components,
      sub {
         my @lineup;
         my %seen;
         my $sum = 0;
         for my $constituent (@_) {
            for my $i (@$constituent) {
               return if $seen{$i}++;
               my $fi = $lk->{fibo}[$i];
               push @lineup, $fi;
               $sum += $fi;
            }
         }
         die "sum mismatch ($sum vs $n)\n" unless $n == $sum;
         my $lineup = join ' + ', sort {$a <=> $b} @lineup;
         print {*STDOUT} "$lineup = $sum\n";
      }
   );
}

sub lekkerkerker {
   my ($n) = @_;
   my @fibo = (1, 2);
   push @fibo, $fibo[-2] + $fibo[-1] while $fibo[-1] < $n;
   my $i = $#fibo;
   my @indexes;
   while ($n > 0) {
      --$i while $fibo[$i] > $n;
      unshift @indexes, $i;
      $n -= $fibo[$i];
   }
   return {
      fibo => \@fibo,
      indexes => \@indexes,
   };
}

# split an input index into the Fibonacci array into possible alternative
# index sets representing the same Fibonacci number in alternative ways,
# down to a lower index $il
sub alternatives {
   my ($i, $il) = @_;
   my @item = ($i);
   my @retval = ([$i]);
   while ($i > $il + 1) {
      pop @item;
      push @item, $i - 1, $i - 2;
      push @retval, [@item];
      $i -= 2;
   }
   return \@retval;
}

# simplified from
# https://github.polettix.it/ETOOBUSY/2020/07/28/nested-loops-recursive/
sub nested_loops_recursive {
   my ($dims, $cb, $accumulator) = @_;
   $accumulator = [] unless defined $accumulator;
   my $level = @{$accumulator};
   if ($level == @{$dims}) { # fire callback!
      $cb->(@{$accumulator});
      return;
   }
   for my $item (@{$dims->[$level]}) {
      push @{$accumulator}, $item;
      nested_loops_recursive($dims, $cb, $accumulator);
      pop @{$accumulator};
   }
   return;
}
