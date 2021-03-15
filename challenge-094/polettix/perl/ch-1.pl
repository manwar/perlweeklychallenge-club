#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Data::Dumper; $Data::Dumper::Indent = 1;

sub group_anagrams (@S) {
   my %group_for;
   for my $item (@S) {
      my $key = join '',
         sort { $a cmp $b }
         map { lc }
         split m{}mxs, $item;
      push $group_for{$key}->@*, $item;
   }
   return [values %group_for];
}

say Dumper group_anagrams(@ARGV);
