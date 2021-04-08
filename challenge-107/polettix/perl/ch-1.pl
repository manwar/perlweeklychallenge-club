#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'sum';

sub nested_loops_iterator {
   my ($dims, $opts, $cb, $accumulator) = @_;
   return unless scalar @{$dims};
   ($opts, $cb) = ($cb, $opts) if ref($opts) eq 'CODE';
   my @indexes     = (-1);
   my @accumulator = (undef) x scalar @{$dims};
   return sub {
      while ((my $level = $#indexes) >= 0) {
         my $dimension = $dims->[$level];
         my $i         = ++$indexes[$level];
         if ($i > $#{$dimension}) { pop @indexes }
         else {
            $accumulator[$level] = $dimension->[$i];
            if   ($level == $#{$dims}) { return @accumulator }
            else                       { push @indexes, -1 }
         }
      }
      return;
   }
}

sub is_self_descriptive (@sequence) {
   for my $i (0 .. $#sequence) {
      my $count = sum map { $_ == $i ? 1 : 0 } @sequence;
      return unless $count == $sequence[$i];
   }
   return 1;
}

sub three_self_descriptive_numbers {
   my ($b, @found) = (1);
   while ('necessary') {
      my $it = nested_loops_iterator([map { [0 .. ($b - 1)]} 1 .. $b]);
      while (my @args = $it->()) {
         push @found, join '', @args if is_self_descriptive(@args);
         return @found if @found == 3;
      }
      ++$b;
   }
   return @found[0..2];
}

say join(', ', three_self_descriptive_numbers());
