#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $n = shift // 5;
say scalar penny_piles_recursive($n)->@*;
say scalar penny_piles_iterative($n)->@*;

my $count = 0;
my $it = penny_piles_iterator($n);
while (my $seq = $it->()) {
   #say "$seq->@*";
   ++$count;
}
say $count;

sub penny_piles_iterator ($n) {
   my @trail;
   my @stack = ($n);
   return sub {
      my $retval = undef;
      while (@stack && ! $retval) {
         $retval = [@trail] if $stack[-1] == 0;
         if (@trail < @stack) { # initialize
            my $min = @trail ? $trail[-1] : 1;
            push @trail, $min;
         }
         else { # continue this frame's iteration
            $trail[-1]++;
         }
         if ($trail[-1] <= $stack[-1]) { # "recurse"
            push @stack, $stack[-1] - $trail[-1];
         }
         else { # "return"
            pop @trail;
            pop @stack;
         }
      }
      return $retval;
   };
}

sub penny_piles_iterative ($n) {
   my @valid;
   my @trail;
   my @stack = ($n);
   while (@stack) {
      push @valid, [@trail] if $stack[-1] == 0;
      if (@trail < @stack) { # initialize
         my $min = @trail ? $trail[-1] : 1;
         push @trail, $min;
      }
      else { # continue this frame's iteration
         $trail[-1]++;
      }
      if ($trail[-1] <= $stack[-1]) { # "recurse"
         push @stack, $stack[-1] - $trail[-1];
      }
      else { # "return"
         pop @trail;
         pop @stack;
      }
   }
   return \@valid;
}

sub penny_piles_recursive ($n) {
   my @valid;
   my @trail;
   sub ($n) {
      push @valid, [@trail] if $n == 0;
      my $min = @trail ? $trail[-1] : 1;
      push @trail, $min;
      while ($trail[-1] <= $n) {
         __SUB__->($n - $trail[-1]);
         ++$trail[-1];
      }
      pop @trail;
   }->($n);
   return \@valid;
}
