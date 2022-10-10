#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Data::Dumper;

my @l = ('1 2', 'p q r', 's 3', '4 5 t');
say Dumper([split_array(@l)]);

sub split_array (@list) {
   my (@digits, @letters);
   for my $item (@list) {
      my (@ds, @ls);
      for my $char (split m{\s+}mxs, $item) {
         if ($char =~ m{\d}mxs) { push @ds, $char }
         else                   { push @ls, $char }
      }
      push @digits,  \@ds if @ds;
      push @letters, \@ls if @ls;
   }
   return (\@digits, \@letters);
}
