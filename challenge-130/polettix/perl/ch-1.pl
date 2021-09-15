#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub odd_number (@inputs) {
   my %is_odd;
   for my $element (@inputs) {
      if ($is_odd{$element}) { delete $is_odd{$element} }
      else                   { $is_odd{$element} = 1    }
   }
   return keys %is_odd;
}

my @inputs = @ARGV ? @ARGV : (2, 5, 4, 4, 5, 5, 2);
say odd_number(@inputs);
